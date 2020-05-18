function A = posture_orientation(signal, fs, helper_plot) 
    labels = evalin("base", sprintf("%s_label", signal));
    g = 9.80665;
    x = evalin("base", signal).*g;
    g_vector = [1,0,0];
    
	A = zeros(length(signal), 1);
    
    for i=1:length(x)
        a = x(i, 1);
        b = x(i, 2);
        c = x(i, 3);
        x_vector = [a,b,c];
        
        g_norm = norm(g_vector);
        x_norm = norm(x_vector);
        
        A(i) = acos(dot(x_vector,g_vector) / x_norm*g_norm) * (180/pi);
    end
    
    if helper_plot == true
            time = (0:length(x)-1)./(60*fs); 
            
		    figure();
            plot(time, A, "k");
            hold on;
            for i = 1 : length(labels)
                start_t = cell2mat(labels(i,2));
                end_t = cell2mat(labels(i,3));
                window = start_t : end_t;
                
                plot(time(window), A(window));
                add_text(A(window),time,labels(i,1),start_t,i);
                hold on;
            end
            %legend(labels(:,1));
            title("Postural Orientation");
            xlabel("Time [min]");
            ylabel("Angle [degrees]");
    end

end

function add_text(data,time,label,pos,index)
	% helper function to position the anotation text in the correct
	% spot in the plot
	
	min_value = min(data);
	max_value = max(data);
	if mod(index, 2) ~= 0
        spot = min_value - (0.1 * min_value);
    else
        spot = max_value - (0.1 * min_value);
	end
	text(time(pos),spot,label);
end