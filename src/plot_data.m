function plot_data(data,fs,sensors,activities,colors)
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
	%		>>> usr_stances (string): labels for the plot
	%		containg the multiple possible stances for a user
	%		in any given moment
	%		>>> colors (string): string array with the colors
	%		for the plot commands	
	% =================================================
	
	time = (0:length(data)-1)./(60*fs); 
	
	figure(1); 
	for k = 1 : length(sensors)
		subplot(length(sensors),1,k);
		plot(time,data(:,k),colors(1,k));
		xlabel("Time (min)");
		ylabel(sensors(1,k));
	end
end