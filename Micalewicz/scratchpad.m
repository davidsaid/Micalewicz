close all
clear all
clc

%%

nDims = 3;
fnsPerDim = 7;
nSamples = 101;
% Compute an artificial series of values
samples = randn( nSamples, nDims );
% Compute the grid of membership functions
[G, lims] = computeMfGrid(samples, fnsPerDim);

figure
X = cell(nDims,1);
Y = cell(nDims,1);
for d = 1:nDims
    X{d} = linspace(lims(1, d) -0.1*lims(2, d),...
                    lims(2, d)+0.1*lims(2, d),....
                    nSamples)';
    Y{d} = cell2mat( cellfun( @(f)f( X{d} ), G(:,d),...
        'UniformOutput', false)' );
    subplot(nDims, 1, d)
    plot( X{d}, Y{d} )
    axis( [-inf, inf, -0.1, 1.1] )
end


