%% Lots of code!! 
%% Path to the DataSet directory
dirpath = "../DataSet";

%% Global Variables
% User stances throughout the study  (labels for the plot)
activities = ["W", "W\_U", "W\_D","SIT", "STAND","LAY", "STAND\_SIT", "SIT\_STAND", "SIT\_LAY", "LAY\_SIT", "STAND\_LAY", "LAY\_STAND"];

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

%% Add DFT calculation
%% Steps calculation for exp11_user06
acts = string(exp11_user06_label(:,1));
acts_index = find(acts == "W" | acts == "W\_D" | acts == "W\_U");
table = zeros(1,length(acts_index))';
j = 1;
for i = acts_index'
    table(j) = get_steps("exp11_user06",fs,i);
    j = j + 1;
end
["Activities Index","Steps Per Minute";acts_index,table]
mean(table)
std(table)

%%
h = hamming(round(2*fs));
STFT("exp11_user06",fs,"all",sensors,h,1,2);
%%
signal_power("exp11_user06",1:20,sensors,true);
