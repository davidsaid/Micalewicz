%% membershipFunctions = computeMfGrid(samples, fnsPerDim)
%
% samples is expected to be a matrix with d columns. Each column i in 
%  membershipFunctions evenly covers the range 
%  [min(samples(:, i)), max(samples(:, i))] using fnsPerDim membership 
%  functions. 
%
% The extreme membership functions extend to the infinity, 
%  so that the entire universe is covered and all off-range inputs produce
%  a valid membership value.

function [membershipFunctions, limits] = computeMfGrid(samples, fnsPerDim)
% Compute the limits for each dimension
limits = [ min(samples,[],1);...
           max(samples,[],1)]; 
% Compute the number of dimensions
nDims = size(limits, 2);
% Initialize the function pointer matrix
membershipFunctions = cell(fnsPerDim, nDims);
% Compute the 
for i=1:nDims
    % Compute the membership function maximum locations
    maximumLoc = linspace( limits(1,i), limits(2, i), fnsPerDim );
    % Generate the function handles of this ro
    for j = 1:fnsPerDim
        if j == 1
            % Lower extreme is a trapezoid that extends to  -infinity
            membershipFunctions{j,i} =...
                @(in)trapmf(in, [-inf, inf, maximumLoc(1:2)] );
        elseif j == fnsPerDim
            % Upper extreme is a trapezoid that extends to infinity
            membershipFunctions{j,i} =...
                @(in)trapmf(in, [maximumLoc(end-1:end), inf, inf] );
        else
            % Central fuzzy sets are triangular with their minimums in the
            %  exact location of it´s neigbour maximums.
            membershipFunctions{j,i} =...
                @(in)trimf(in, maximumLoc([-1:1] + j));
        end
    end 
end




