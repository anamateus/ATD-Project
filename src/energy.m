function E = energy(signal, activities, sensors) 
    x = evalin("base", signal);
    labels = evalin("base", sprintf("%s_label", signal));
    E = zeros(length(activities), length(sensors));
   
    for act = activities
        start = cell2mat(labels(act, 2));
        finish = cell2mat(labels(act, 3));
        for sensor = 1:length(sensors)
            E(act, sensor) = double(sum(abs(x(start:finish, sensor)).^2));
        end
    end
    
    figure();
    x_labels = labels(activities, 1);
    
    for s = 1 : length(sensors)
        subplot(3,1,s)
        stem(activities, E(:,s));
        xlabel(x_labels);
        ylabel(sprintf("%s\n Energy",sensors(s)));
        grid on;	
    end
end