function resultArr = createFit(refArr, yArr)
%%
if size(refArr,1)>size(refArr,2)
    refArr = refArr';
    yArr = yArr';
end
resultArr= cell(1,3);
% Set up fittype and options.
ft = fittype( 'fourier8' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf -Inf -Inf -Inf -Inf -Inf...
    -Inf -Inf -Inf -Inf -Inf -Inf -Inf -Inf 0.999];
% opts.Normalize = 'on';
opts.StartPoint = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
opts.Upper = [Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf...
    Inf Inf Inf Inf Inf Inf 1.001];
for i = 1: size(refArr,1)
    [xData, yData] = prepareCurveData( refArr(i,:)*pi/180, yArr(i, :) );   
    [fitresult, gof] = fit( xData, yData, ft, opts );
    
    resultArr{1}(i,1)=abs(fitresult.a0);
    resultArr{1}(i,2)=sqrt(fitresult.a1^2+fitresult.b1^2);
    resultArr{1}(i,3)=sqrt(fitresult.a2^2+fitresult.b2^2);
    resultArr{1}(i,4)=sqrt(fitresult.a3^2+fitresult.b3^2);
    resultArr{1}(i,5)=sqrt(fitresult.a4^2+fitresult.b4^2);
    resultArr{1}(i,6)=sqrt(fitresult.a5^2+fitresult.b5^2);
    resultArr{1}(i,7)=sqrt(fitresult.a6^2+fitresult.b6^2);
    resultArr{1}(i,8)=sqrt(fitresult.a7^2+fitresult.b7^2);
    resultArr{1}(i,9)=sqrt(fitresult.a8^2+fitresult.b8^2);
    
    resultArr{2}(i,1)= -angle(fitresult.a0) *180/pi;
    resultArr{2}(i,2)= -atan2d(fitresult.b1,fitresult.a1);
    resultArr{2}(i,3)= -atan2d(fitresult.b2,fitresult.a2);
    resultArr{2}(i,4)= -atan2d(fitresult.b3,fitresult.a3);
    resultArr{2}(i,5)= -atan2d(fitresult.b4,fitresult.a4);
    resultArr{2}(i,6)= -atan2d(fitresult.b5,fitresult.a5);
    resultArr{2}(i,7)= -atan2d(fitresult.b6,fitresult.a6);
    resultArr{2}(i,8)= -atan2d(fitresult.b7,fitresult.a7);
    resultArr{2}(i,9)= -atan2d(fitresult.b8,fitresult.a8);
    resultArr{3}(i) = fitresult.w;
end
end



