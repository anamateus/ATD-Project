function  dft_coefs = fragment_dft_plot(exp_usr_name,fs,sensors,plotable,first,last)
    data_name = exp_usr_name;
    label_name = sprintf("%s_label",exp_usr_name);
    data = evalin('base', data_name);
    label = evalin('base',label_name);
    n_activities = length(label);
    dft_coefs = cell(n_activities,1,3);
    times = [[label{:,2}]',[label{:,3}]'];
    
    for i = 1:n_activities
        for j = 1:3
            dft_centered = fftshift(fft(data(times(i,1):times(i,2),j)));
            dft_coefs{i,1,j} = {dft_centered};
        end 
    end
    
    if (plotable == "true")
        sgtitle("DFT plots of " + exp_usr_name + " ACT["+first+","+ last+"]",'Interpreter','none');
        n_activities = length(first:last);
        for i = first:last
            
            N = length(data(times(i,1):times(i,2)));
            fo = fs/N;
            if mod(N,2) == 0
                n = -N/2: N/2 - 1;
            else
                n = -fix(N/2): fix(N/2);
            end
            freq = n * fo; 
            for j = 1:3
                subplot(3,n_activities,(i - first + 1) + n_activities*(j-1));
                plot(freq,abs(cell2mat(dft_coefs{i,1,j})));
                if((i - first + 1) == 1)
                    ylabel(sensors(j));  
                end
            end
            xlabel('frequency [Hz]')
        end       
    end
end