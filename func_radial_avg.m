function [R_AVG, R_POS] = func_radial_avg(IMSQ, BINS)%rmax)

N = size(IMSQ,1);
[X,Y] = meshgrid(-1:2/(N-1):1);
r = sqrt(X.^2+Y.^2);
% equi-spaced points along radius which bound the bins to averaging radial values
% bins are set so 0 (zero) is the midpoint of the first bin and 1 is the last bin
dr = 1/(BINS-1);
rbins = linspace(-dr/2,1+dr/2,BINS+1);
% radial positions are midpoints of the bins
R_POS = N*sqrt(2)/2*(rbins(1:end-1)+rbins(2:end))/2;
R_AVG = zeros(1,BINS); % vector for radial average
nans = ~isnan(IMSQ); % identify NaNs in input data
% loop over the bins, except the final (r=1) position
for j=1:BINS-1
	% find all matrix locations whose radial distance is in the jth bin
	bins = r>=rbins(j) & r<rbins(j+1);
	
	% exclude data that is NaN
	bins = logical(bins .* nans);
	
	% count the number of those locations
	n = sum(sum(bins));
	if n~=0
		% average the values at those binned locations
 		R_AVG(j) = sum(IMSQ(bins))/n;
	else
		% special case for no bins (divide-by-zero)
		R_AVG(j) = NaN;
	end
end
% special case the last bin location to not average Z values for
% radial distances in the corners, beyond R=1
bins = r>=rbins(BINS) & r<=1;
% exclude data that is NaN
bins = logical(bins .* nans);
n = sum(sum(bins));
if n~=0
	% average the values at those binned locations
 	R_AVG(BINS) = sum(IMSQ(bins))/n;
else
	R_AVG(BINS) = NaN;
end