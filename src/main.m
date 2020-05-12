%% Lots of code!! 
%% Path to the DataSet directory
dirpath = "../DataSet";

%% Global Variables
% User stances throughout the study  (labels for the plot)
activities = ["W", "W\_U", "W\_D","SIT", "STAND","LAY", "STAND\_SIT", "SIT\_STAND", "SIT\_LIE", "LIE\_SIT", "STAND\_LIE", "LIE\_STAND"];

% Accelerometers (Sensors available to get the data in the X Y and Z axis)
sensors = ["ACC\_X","ACC\_Y","ACC\_Z"];

% Sampling frequency used by the sensors
fs = 50;

%% Main 

[exp,usr] = load_data(dirpath);
get_labels(labels,activities,exp,usr);

%% Plot all figures (Sorry for the spam...)
for i = 1 : length(1)
	data = sprintf("exp%d_user%.2d",exp(i),usr(i));
	data_label = sprintf("exp%d_user%.2d_label",exp(i),usr(i));
	plot_data(eval(data),fs,sensors,eval(data_label),i);
end




