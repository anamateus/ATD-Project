function  dft_coefs = dft(exp_usr_name,fs,sensors,acts,varargin)
    % ==================== dft  ====================
	% Description: This function calculates the DFT for a certain
	% experience, for a given set of activities 
	% Arguments :
	%		>>> exp_usr_name (string): e.g "exp11_user06"
    %       Optional for plotting:
    %       >>> fs (double) : Sampling Frequency 
    %       >>> sensors (string matrix) : Accelerometers names
    %       >>> acts (double vector) : Activities to plot
	% Return: 
	%		>>> dft_coefs : multidimensional cell array with all the
	%		experience DFTs.
    %       dft_coefs(:,1,1) => X accelerometer DFTs
    %       dft_coefs(:,1,2) => Y accelerometer DFTs
    %       dft_coefs(:,1,3) => Z accelerometer DFTs
    %       
	% =================================================
    % Getting Workspace Variables
    
    data_name = exp_usr_name;
    label_name = sprintf("%s_label",exp_usr_name);
    data = evalin('base', data_name);
    label = evalin('base',label_name);
    % Auxiliar Variables
    n_activities = length(label);
    dft_coefs = cell(n_activities,1,3);
    times = [[label{:,2}]',[label{:,3}]'];
    % DFT calculation
    for i = 1:n_activities
        for j = 1:3
		win= 1;
		name = "rectangular";
		if ~isempty(varargin)
			    name = varargin(1);
			    window =  eval("@"+ varargin(1));
			    win = window(times(i,2) - times(i,1) + 1);
		end
            dft_centered = fftshift(fft(detrend(data(times(i,1):times(i,2),j)).*win));
            dft_coefs{i,1,j} = {dft_centered};
        end 
    end
    % Plotting
    if nargin > 1
        sgtitle("DFT plots of " + exp_usr_name + " window [ " + name + " ]",'Interpreter','none');
        n_activities = length(acts);
        frame_counter = 1;
        for i = acts 
            N = length(data(times(i,1):times(i,2)));
            % Resolution in frequency
            fo = fs/N;
            if mod(N,2) == 0
                n = -N/2: N/2 - 1;
            else
                n = -fix(N/2): fix(N/2);
            end
            % Linear Frequency Domain
            freq = n * fo;
            % True Plotting
            for j = 1:3
                subplot(3,n_activities,frame_counter + n_activities*(j-1));
                plot(freq,abs(cell2mat(dft_coefs{i,1,j})));
                if(frame_counter == 1)
                    ylabel(sensors(j));  
                end
            end
            xlabel(sprintf(' [%s] frequency [Hz]',label{i,1}));
            frame_counter = frame_counter + 1;
        end
    end
end