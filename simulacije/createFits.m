function [fitresult, gof] = createFits(ref1, sinus1, cosinus1)
%CREATEFITS(REF1,SINUS1,COSINUS1)
%  Create fits.
%
%  Data for 'untitled fit 1' fit:
%      X Input : ref1
%      Y Output: sinus1
%  Data for 'untitled fit 2' fit:
%      X Input : ref1
%      Y Output: cosinus1
%  Output:
%      fitresult : a cell-array of fit objects representing the fits.
%      gof : structure array with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 05-Jul-2018 13:22:28

%% Initialization.

% Initialize arrays to store fits and goodness-of-fit.
fitresult = cell( 2, 1 );
gof = struct( 'sse', cell( 2, 1 ), ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );

%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( ref1, sinus1 );

% Set up fittype and options.
ft = fittype( 'a0+a1*cosd(x+f1)+a2*cosd(2*x+f2)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf -Inf];
opts.StartPoint = [0.957506835434298 0.964888535199277 0.959492426392903 0.157613081677548 0.849129305868777];
opts.Upper = [Inf Inf Inf Inf Inf];
% Fit model to data.
[fitresult{1}, gof(1)] = fit( xData, yData, ft, opts );



%% Fit: 'untitled fit 2'.
[xData, yData] = prepareCurveData( ref1, cosinus1 );

% Set up fittype and options.
ft = fittype( 'a0+a1*cosd(x+f1)+a2*cosd(2*x+f2)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf -Inf];
opts.StartPoint = [0.141886338627215 0.421761282626275 0.933993247757551 0.915735525189067 0.678735154857773];
opts.Upper = [Inf Inf Inf Inf Inf];
% Fit model to data.
[fitresult{2}, gof(2)] = fit( xData, yData, ft, opts );

