function SMV = magnitude_vector(signal, fs, helper_plot) 
        g = 9.80665;
	    x = evalin("base", signal).*g;
	    labels = evalin("base", sprintf("%s_label", signal));
	    SMV = zeros(length(signal), 1);
   
        for i=1:length(x)
            a = x(i, 1).^2;
            b = x(i, 2).^2;
            c = x(i, 3).^2;
            SMV(i) = sqrt(a + b + c);
        end
        
       
        if helper_plot == true
            time = (0:length(x)-1)./(60*fs); 
            
            
		    figure();
            plot(time, SMV, "k");
            hold on;
            for i = 1 : length(labels)
                start_t = cell2mat(labels(i,2));
                end_t = cell2mat(labels(i,3));
                window = start_t : end_t;
                
                plot(time(window), SMV(window));
                
                hold on;
            end
            legend(labels(:,1));
            title("Signal Magnitude Vector (SMV)");
            xlabel("Time [min]");
            ylabel("Magnitude [m/s^2]");
            
        end
end