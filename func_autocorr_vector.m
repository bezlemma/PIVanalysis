function [rpos,gr] = func_autocorr_vector(useries,vseries)

u = cell2mat(useries);
v = cell2mat(vseries);

%Try to use square data sets if possible
[xsize, ysize] = size(u);
minsize = min(xsize,ysize);
xcrop = (xsize-minsize)/2;
ycrop = (ysize-minsize)/2;
u = u(  (xcrop +1 ):(end-xcrop), (ycrop +1 ):(end-ycrop)  );
v = v(  (xcrop +1 ):(end-xcrop), (ycrop +1 ):(end-ycrop)  );

%Remove drift and NaNs, this will alter results if there are many NaNs
u(isnan(u))=0; v(isnan(v))=0;
u = u - mean2(u);
v = v - mean2(v);

%perform fft
u_corr = fftshift(ifft2(fft2(u).*conj(fft2(u))));
v_corr = fftshift(ifft2(fft2(v).*conj(fft2(v))));

%The following is necessary if no drift removal is performed
%u_corr = fftshift(ifft2(fft2(u).*conj(fft2(u-mean2(u)))));
%v_corr = fftshift(ifft2(fft2(v).*conj(fft2(v-mean2(v)))));

%Sum fields
data_corr = (u_corr + v_corr);

[xsize, ysize] = size(data_corr);
rmax = floor(min(xsize/2,ysize/2));
[gr, rpos] = func_radial_avg(data_corr, rmax) ;

gr(1) = []; %Get rid of 1-pixel noise
rpos(1) = [];

end

