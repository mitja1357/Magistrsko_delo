function [fitresult, gof] = createFits(ref1, sinus1, cosinus1, frek)
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
%%%%%%%%%%%%%%%%%%%
%%% s frekvenco %%%
%%%%%%%%%%%%%%%%%%%
if frek
ft = fittype( 'a0 + a1*cosd(x*w+f1) + a2*cosd(2*x*w+f2)+ a3*cosd(3*x*w+f3)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf  -Inf -Inf -Inf 0.9];
opts.StartPoint = [0.141886338627215 0.421761282626275 0.933993247757551 0.915735525189067 0.678735154857773 0.915735525189067 0.678735154857773 1];
opts.Upper = [Inf Inf Inf Inf Inf Inf Inf 1.1];
else
%%%%%%%%%%%%%%%%%%%%%%
%%% brez frekvence %%%
%%%%%%%%%%%%%%%%%%%%%%

ft = fittype( 'a0 + a1*cosd(x*w+f1) + a2*cosd(2*x*w+f2)+ a3*cosd(3*x*w+f3)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf  -Inf -Inf -Inf 0.9999999999999999999];
opts.StartPoint = [0.141886338627215 0.421761282626275 0.933993247757551 0.915735525189067 0.678735154857773 1];
opts.Upper = [Inf Inf Inf Inf Inf Inf Inf 1.000000000000001];
end

% Fit model to data.
[fitresult{1}, gof(1)] = fit( xData, yData, ft, opts );


%% Fit: 'untitled fit 2'.
[xData, yData] = prepareCurveData( ref1, cosinus1 );


% Set up fittype and options.
%%%%%%%%%%%%%%%%%%%
%%% s frekvenco %%%
%%%%%%%%%%%%%%%%%%%
enacba = strcat('a0 + a1*cosd(x*',...
        num2str(fitresult{1}.w,'%10.6e\n'),...
        '+f1) + a2*cosd(2*x*',num2str(fitresult{1}.w,'%10.6e\n'),...
        '+f2)+ a3*cosd(3*x*',num2str(fitresult{1}.w,'%10.6e\n'),'+f3)');
if frek
    
    
ft = fittype( enacba, 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf  -Inf -Inf -Inf];
opts.StartPoint = [0.141886338627215 0.421761282626275 0.933993247757551 0.915735525189067 0.678735154857773 0.915735525189067 0.678735154857773];
opts.Upper = [Inf Inf Inf Inf Inf Inf Inf];
else
%%%%%%%%%%%%%%%%%%%%%%
%%% brez frekvence %%%
%%%%%%%%%%%%%%%%%%%%%%

ft = fittype( enacba , 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf  -Inf];
opts.StartPoint = [0.141886338627215 0.421761282626275 0.933993247757551 0.915735525189067 0.678735154857773];
opts.Upper = [Inf Inf Inf Inf Inf];
end

% Fit model to data.
[fitresult{2}, gof(2)] = fit( xData, yData, ft, opts );


