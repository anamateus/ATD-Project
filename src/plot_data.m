function plot_data(data,fs,sensors,activities,fig_num)
	% ==================== plot_data  ====================
	% This funtion is responsible for ploting the data adquired from
	% the sensors in all 3 axes with a given sampling frequency.The
	% plot may take some configuration arguments like for example the
	% labels that will be used to highlight the intput data features
	% Arguments :
	%		>>> data (double): Matrix of doubles containing 3
	%		columns with the values for the sensors in the 3
	%		different axes (ACC_X,ACC_Y;ACC_Z)
	%		>>> fs (double): Sampling frequency (in Hz) used
	%		bye the sensors to obtain the values of
	%		acceleration
	%		>>> sensors (string): labels that identify each
	%		component (axis) of the sensor
	%		>>> activities (cell array): labels for the plot
	%		containg the multiple possible stances for a user
	%		in any given moment and the start and ending times
	%		for any stance.
	%		>>> number for the matlab figure where the plot
	%		will apear
	% =================================================

	time = (0:length(data)-1)./(60*fs); 
	start_t = cell2mat(activities(:,2));
	end_t = cell2mat(activities(:,3));
	
	figure(fig_num)
	for k = 1 : length(sensors)
		subplot(length(sensors),1,k);
		axis([0, time(end) min(data(:,k)) max(data(:, k))])
		plot(time,data(:,k),"k"); 
		hold on;
		for w = 1 : length(activities)
			window = start_t(w) : end_t(w);
			plot(time(window),data(window,k));
			add_text(data(:,k),time,activities(w,1),start_t(w));
			hold on;
		end
		xlabel("Time (min)");
		ylabel(sensors(1,k));
	
	end
end

function add_text(data,time,label,index)
	% helper function to position the anotation text in the correct
	% spot in the plot
	
	min_value = min(data);
	max_value = max(data);
	if mod(index, 2) ~= 1
                spot = min_value - (0.1 * min_value);
	else
                spot = max_value - (0.1 * min_value);
	end
	text(time(index),spot,label);
end

