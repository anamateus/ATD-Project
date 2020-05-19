function dft_max_3d_plot(exp_usr_name,fs,transition,plotting)
    % Getting Workspace Variables
    data_name = exp_usr_name;
    label_name = sprintf("%s_label",exp_usr_name);
    data = evalin('base', data_name);
    label = evalin('base',label_name);
    window =  eval("@hamming");
    % Aux vars
    n_activities = length(label);
    times = [[label{:,2}]',[label{:,3}]'];
    table = zeros(n_activities,3,2);
    for i = 1:n_activities
        win = window(times(i,2) - times(i,1) + 1);
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
        for j = 1:3
            dft = abs(fftshift(fft(detrend(data(times(i,1):times(i,2),j)).*win)));
            table(i,j,1) = max(dft);
            index = dft == table(i,j);
            freq_max_magnitude = freq(index);
            table(i,j,2) = freq_max_magnitude(freq_max_magnitude>=0);
        end
    end
    % Getting labels
    labels = string(label);
    labels = labels(:,1);
    % Gettting label indexes
    walk_index = find(labels == "W");
    walku_index = find(labels == "W\_U");
    walkd_index = find(labels == "W\_D");
    sit_index = find(labels == "SIT");
    lay_index = find(labels == "LAY");
    stand_index = find(labels == "STAND");
    
    stsit = find(labels == "STAND\_SIT");
    ststand = find(labels == "SIT\_STAND");
    sittl = find(labels == "SIT\_LAY");
    ltsit = find(labels == "LAY\_SIT");
    standtl = find(labels == "STAND\_LAY");
    ltstand = find(labels == "LAY\_STAND");
    % Plotting
    
    titles = ["Magnitude","Frequency"];
    index = find(titles == plotting);
    for i = index
        %figure();
        % Dinamic
        if ~isempty(walk_index)
            plot3(table(walk_index,1,i),table(walk_index,2,i),table(walk_index,3,i),"bo",'DisplayName',"WALK");
        end
        hold on
        if ~isempty(walku_index)
            plot3(table(walku_index,1,i),table(walku_index,2,i),table(walku_index,3,i),"ro",'DisplayName',"WALK_U_P");
        end
        if ~isempty(walkd_index)
            plot3(table(walkd_index,1,i),table(walkd_index,2,i),table(walkd_index,3,i),"go",'DisplayName',"WALK_D_O_W_N");
        end
        % Static
        if ~isempty(stand_index)
            plot3(table(stand_index,1,i),table(stand_index,2,i),table(stand_index,3,i),"bx",'DisplayName',"STAND");
        end
        if ~isempty(sit_index)
            plot3(table(sit_index,1,i),table(sit_index,2,i),table(sit_index,3,i),"rx",'DisplayName',"SIT");
        end
        if ~isempty(lay_index)
            plot3(table(lay_index,1,i),table(lay_index,2,i),table(lay_index,3,i),"gx",'DisplayName',"LAY");
        end
        % Transitions
        if transition == "true"
            if ~isempty(stsit)
                plot3(table(stsit,1,i),table(stsit,2,i),table(stsit,3,i),"y*",'DisplayName',"Stand->Sit");
            end
            if ~isempty(ststand)
                plot3(table(ststand,1,i),table(ststand,2,i),table(ststand,3,i),"y+",'DisplayName',"Sit->Stand");
            end
            if ~isempty(sittl)
                plot3(table(sittl,1,i),table(sittl,2,i),table(sittl,3,i),"yx",'DisplayName',"Sit->Lay");
            end
            if ~isempty(ltsit)
                plot3(table(ltsit,1,i),table(ltsit,2,i),table(ltsit,3,i),"c*",'DisplayName',"Lay->Sit");
            end
            if ~isempty(standtl)
                plot3(table(standtl,1,i),table(standtl,2,i),table(standtl,3,i),"c+",'DisplayName',"Stand->Lay");
            end
            if ~isempty(ltstand)
                plot3(table(ltstand,1,i),table(ltstand,2,i),table(ltstand,3,i),"cx",'DisplayName',"Lay->Stand");
            end
        end
        % Title
        title(titles(i)+' of max(DFT)')
        % Max DFT values in the signal:
        xlabel('ACC_X')
        ylabel('ACC_Y')
        zlabel('ACC_Z')
        %{
        switch i
            case 1
                
            case 2
                [x,y] = meshgrid(0:0.1:10);surf(x,0.5+0*y+0*x,y);surf(x,y,0*x+0*y + 0.5);surf(0.5+0*y+0*x,x,y);
        end
        %}
        legend show;
    end
end