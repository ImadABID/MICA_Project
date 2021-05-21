function is_atrial_fibrillation = atrial_fibrillation(Sig, plot_locations_opt)

    %% computing delta_R
    [P, Q, R, S, T] = wave_detection_PQRST(Sig.ecg, 1/(Sig.Fs), 2, 'no plot');
    delta_R = zeros(1, length(R)-1);
    for i=1:1:length(R)-1
        delta_R(i) = R(i+1) - R(i);
    end
    delta_R = delta_R - mean(delta_R);
    
    %% Correlation
    
    N = length(delta_R);
    
    correlation_estimation = zeros(1, N);
    for k=0:1:N-1
        prod = zeros(1, N-k);
        for n=0:1:N-k-1
            prod(n+1) = delta_R(n+k+1) * delta_R(n+1);
        end
        correlation_estimation(k+1) = 1/(N-k-1) .* sum(prod);
    end
    
    %% Avoiding edge effects
    correlation_estimation = correlation_estimation(1:1:floor(N/2));
    
    %% Result
    if(correlation_estimation(1) > 10 * mean(correlation_estimation))
        is_atrial_fibrillation = 1;
    else
        is_atrial_fibrillation = 0;
    end
    
    %% Testing
    if(strcmp(plot_locations_opt, 'plot'))
        figure
        plot(correlation_estimation)
    end
end

