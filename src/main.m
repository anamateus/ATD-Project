%% Lots of code!! 
%% Path to the DataSet directory
dirpath = "../DataSet";

%% Global Variables
% User stances throughout the study  (labels for the plot)
activities = ["W", "W\_U", "W\_D","SIT", "STAND","LAY", "STAND\_SIT", "SIT\_STAND", "SIT\_LIE", "LIE\_SIT", "STAND\_LIE", "LIE\_STAND"];

% Colors ( To be used when plotting)
colors = ["r", "b", "g", "w", "k", "y","m", "c"];

% Accelerometers (Sensors available to get the data in the X Y and Z axis)
sensors = ["ACC\_X","ACC\_Y","ACC\_Z"];

% Sampling frequency used by the sensors
fs = 50;

%% Main 

[exp,usr] = load_data(dirpath);
get_labels(labels,activities,exp,usr);

plot_data(exp11_user06,fs,sensors,activities,colors);




