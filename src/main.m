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
dft("exp11_user06",fs,sensors,[3,13]);
dft("exp11_user06",fs,sensors,[3,13],"hamming");
dft("exp11_user06",fs,sensors,[3,13],"gausswin");
dft("exp11_user06",fs,sensors,[3,13],"blackman");

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
%% STFT Experiments Zone
s = detrend(eval("exp11_user06"));
STFT("exp11_user06",fs,"all",sensors,"rectwin",0.05,0.5);
matlab_stft_plot(s,fs,rectwin(round(0.5*fs)),0.05,0.5);

STFT("exp11_user06",fs,"all",sensors,"hamming",1,2);
matlab_stft_plot(s,fs,hamming(round(2*fs)),1,2);

STFT("exp11_user06",fs,"all",sensors,"hamming",0.05,0.5);
matlab_stft_plot(s,fs,hamming(round(0.5*fs)),0.05,0.5);
%% Signal Power Experiments Zoneh = hamming(round(2*fs));
signal_power("exp11_user06",1:20,sensors,true);

%% SMV Experiments Zone
magnitude_vector("exp11_user06", fs, true);

%% Angle Experiments Zone
posture_orientation("exp11_user06", fs, true);

%% All activities Experiments Zone
exps = ["exp11_user06", "exp12_user06", "exp13_user07", "exp14_user07", "exp15_user08", "exp16_user08", "exp17_user09", "exp18_user09", "exp19_user10","exp20_user10"];
figure();
for k = exps
    dft_max_3d_plot(k, fs,"true","Magnitude");
    hold on;
end
hold on


%% Matlab stft helper function

function matlab_stft_plot(signal,fs,window,overlap_len,dft_len)
	figure();
	for i = 1 : size(signal,2)
		subplot(3,1,i);
		stft(signal(:,i),fs,'Window',window,'OverlapLength',round(overlap_len*fs),'FFTLength',round(dft_len*fs));	
	end
end


