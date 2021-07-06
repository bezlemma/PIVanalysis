function [rpos,gr] = func_autocorr_scalar(rho)

%Try to use square data sets if possible
[xsize, ysize] = size(rho);
minsize = min(xsize,ysize);
xcrop = (xsize-minsize)/2;
ycrop = (ysize-minsize)/2;
rho = rho(  (xcrop +1 ):(end-xcrop), (ycrop +1 ):(end-ycrop)  );

%remove nans
rho(isnan(rho))=0; v(isnan(v))=0;

%Think carefully about whether or not you should subtract the mean 
rho_corr = fftshift(ifft2(fft2(u).*conj(fft2(u-mean2(u)))));

[xsize, ysize] = size(rho_corr);
rmax = floor(min(xsize/2,ysize/2));
[gr, rpos] = func_radial_avg(rho_corr, rmax) ;

gr(1) = []; %Get rid of 1-pixel noise
rpos(1) = [];

end

