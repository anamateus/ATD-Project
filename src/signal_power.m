function P = signal_power(signal, activities, sensors, domain,helper_plot) 
	    x = evalin("base", signal);
	    labels = evalin("base", sprintf("%s_label", signal));
	    P = zeros(length(activities), length(sensors));
   
	    for act = activities
		start = cell2mat(labels(act, 2));
		finish = cell2mat(labels(act, 3));
		for sensor = 1 : length(sensors)
            if domain == "frequency"
    		    P(act, sensor) = double(sum(abs(fftshift(fft(x(start:finish, sensor))).^2)) / (finish-start));
            elseif domain == "time"
                P(act, sensor) = double(sum(abs(x(start:finish, sensor).^2)) / (finish-start));
            end
		end
	    end
	    
	    if helper_plot == true
		    figure();
		    x_labels = string(labels(:,1));
		    for s = 1 : length(sensors)
			subplot(4,1,s)

			stem(activities(activities < 13) , P(activities < 13,s),"filled","b");
			hold on;
			stem(activities(activities >= 13) , P(activities >= 13,s),"filled","r");
			set(gca,"XTick",activities,"XTickLabel",x_labels);

			ylabel(sprintf("%s\n Power",sensors(s)));
			legend(["Static activities", "Dynamic activities"]);
			grid on;	
		    end
		     subplot(4,1,4);
		     Psum  = sum(P,2);
		     
		     stem(activities(activities < 13) , Psum(activities < 13),"filled","b");
		     hold on;
		     stem(activities(activities >= 13) , Psum(activities >= 13),"filled","r");
		     set(gca,"XTick",activities,"XTickLabel",x_labels);
		    
		    ylabel("Power Sum");
		    legend(["Static activities", "Dynamic activities"]);
		    grid on;
	    end
end