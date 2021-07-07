function [HALFWIDTH] = func_find_correlation_length(u, v,tmin, step, tmax, scale,PIVbin,MID_POINT,X_BUFFER,FIT_START_POINT)

for kk = tmin:step:tmax
    kk
    [rpos, ravg] = func_autocorr_vector(u(kk),v(kk));
    ravg = ravg / ravg(1);
    rpos = rpos * scale * PIVbin;

    CustomFit = fittype('a1*exp(-(x/c1)^2)+d1');
    myoptions = fitoptions(CustomFit); 
    myoptions.StartPoint = FIT_START_POINT;
    myoptions.Algorithm = 'Levenberg-Marquardt'; %'Trust-Region'
    B = find(ravg <  MID_POINT);
    xList2 = 1:B(1)+X_BUFFER;
    try
        f2 = fit(rpos(xList2)',ravg(xList2)',CustomFit,myoptions);
        yfit2 = f2.a1*exp(-(rpos(xList2)./(f2.c1)).^2) + f2.d1;
        HALFWIDTH(kk) = f2.c1;
    catch
        HALFWIDTH(kk) = NaN;
    end    
end

end
