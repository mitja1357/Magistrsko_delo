function slike_analognih_signalov(varargin)

        
    if nargin == 1 && isstruct(varargin{1})
        meritev = varargin{1};
        ime=inputname(1);
        risi1=1;
        while (ishandle(risi1) && strcmp(get(risi1, 'type'), 'figure'))
            risi1 = 1+risi1;
        end
    elseif nargin == 2 && isstruct(varargin{1}) && isnumeric(varargin{2})
        meritev = varargin{1};
        ime=inputname(1);
        risi1=round(varargin{2});
    else
        error('zrihtaj vhod')
        
    end
    
    fft_cos = mojfft(meritev.cos);
    fft_sin = mojfft(meritev.sin);
    
    mean_cos = fft_cos{1}(:,1).*cosd(fft_cos{2}(:,1));
    mean_sin = fft_sin{1}(:,1).*cosd(fft_sin{2}(:,1));
    
    cos_1st_amp = fft_cos{1}(:,2);
    sin_1st_amp = fft_sin{1}(:,2);
    
    cos_1st_phase = fft_cos{2}(:,2);
    sin_1st_phase = fft_sin{2}(:,2)+90;
    
    cos_2nd_amp = fft_cos{1}(:,3);
    sin_2nd_amp = fft_sin{1}(:,3);
    
    
    figure(risi1)
    set(risi1,'Name',ime)
    
    subplot(2,2,1)
    plot(meritev.displacement, mean_cos, meritev.displacement, mean_sin);
    legend('cos', 'sin')
    title('offset')
    grid on
    
        
    subplot(2,2,2)
    plot(meritev.displacement, cos_1st_amp, meritev.displacement, sin_1st_amp);
    legend('cos', 'sin')
    title('1st amp')
    grid on
    
    subplot(2,2,3)
    plot(meritev.displacement, cos_2nd_amp, meritev.displacement, sin_2nd_amp);
    legend('cos', 'sin')
    title('2nd amp')    
    grid on
    
    subplot(2,2,4)
    plot(meritev.displacement, cos_1st_phase, meritev.displacement, sin_1st_phase);
    legend('cos', 'sin')
    title('1st phase')     
    grid on
    
    
    
    
    
    
    
    
    
    
    
    
    
end