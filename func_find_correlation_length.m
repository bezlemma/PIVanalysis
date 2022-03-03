function [DECAY_LENGTH] = func_find_correlation_length_exponential(u, v,tmin, step, tmax, scale,PIVbin,X_BUFFER,FIT_START_POINT)


if nargin < 8
    X_BUFFER = 5;
end
if nargin < 9
   FIT_START_POINT = [1.7 100 0];
end

for kk = tmin:step:tmax
    kk
    [rpos, ravg] = func_autocorr_vector(u(kk),v(kk));
    ravg = ravg / ravg(1);
    rpos = rpos * scale * PIVbin;

    CustomFit = fittype('a1*exp(-x/b1)+c1');
    myoptions = fitoptions(CustomFit); 
    myoptions.StartPoint = FIT_START_POINT;
    myoptions.Lower = [0 1 -100];
    myoptions.Upper = [10 1000 100];
    myoptions.Algorithm = 'Trust-Region';
    B = find(ravg < 0);
    if B(1) > X_BUFFER
        xList2 = X_BUFFER:B(1);
    else
        xList2 = X_BUFFER:length(ravg-1);
    end
    try
        f2 = fit(rpos(xList2)',ravg(xList2)',CustomFit,myoptions);
        yfit = f2.a1*exp(-rpos(xList2)./(f2.b1)) + f2.c1;
        DECAY_LENGTH(kk) = -log((0.3-f2.c1)/f2.a1)*f2.b1;
    catch
        DECAY_LENGTH(kk) = NaN;
    end    

end




end