function S = STFT(x,fs,activities,sensors,window,overlap_len,dft_len)

		X = evalin("base",x);
		flag = 0;
		if strcmp(activities,"all") ~= 0
			a = 1;
			b = length(X);
			activities = 1;
			labels = "all";
		else
			labels = evalin("base",sprintf("%s_label",x));
			flag = 1;
		end

		for act = activities
			if flag == 1
				a = cell2mat(labels(act,2));
				b = cell2mat(labels(act,3));	
			end
			signal = detrend( X( a : b , : ));
			
			n_pts = length(signal);
			time = linspace(0,(n_pts - 1)/fs,n_pts);

			n_frame_samples = round(dft_len*fs);
			n_frame_overlaps = round(overlap_len*fs);
			freq_frame = linfreq_resolution(fs,n_frame_samples);

			nwindows =  1 : n_frame_samples - n_frame_overlaps : n_pts - n_frame_samples;
			S = zeros(length(nwindows),size(signal,2));
			time_frames = zeros(length(nwindows),size(signal,2));
			for acc = 1 : size(signal,2)
				i = 1;
				for k = nwindows
					frame = signal(k : k + n_frame_samples - 1,acc).*window;
					frame_dft = abs(fftshift( fft(frame) ));
					index =  find(frame_dft == max(frame_dft),1,"last");
					S(i,acc) = freq_frame(index);
					f_time = time(k : k + n_frame_samples - 1);
					time_frames(i,acc) = f_time(round(n_frame_samples/2) + 1);
					i = i + 1;
				end
			end

			figure();
			title = sprintf("Short Time Fourier Transform of "+ x + " [ activity : %s ] (most relevant frequencies)",labels{act}); 
			sgtitle(title ,'Interpreter','none');
			for acc = 1 : size(S,2)
				subplot(3,1,acc)
				plot(time_frames,S(:,acc), "ro");
				xlabel("time [s]");
				ylabel(sprintf("%s\n Frequency [Hz]",sensors(acc) ));
				grid on;	
			end
		end
end

function F = linfreq_resolution(fs,n_samples)
	if mod(n_samples,2) == 0
	    F = -fs/2 : fs/n_samples : fs/2 - fs/n_samples;
	else
	    F = -fs/2 + fs/(2*n_samples) : fs/n_samples : fs/2 - fs/(2*n_samples);
	end
end