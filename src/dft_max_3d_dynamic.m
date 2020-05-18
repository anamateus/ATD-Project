function dft_max_3d_dynamic(exp_usr_name)
    % Getting Workspace Variables
    
    data_name = exp_usr_name;
    label_name = sprintf("%s_label",exp_usr_name);
    data = evalin('base', data_name);
    label = evalin('base',label_name);
    window =  eval("@hamming");
    % Aux vars
    n_activities = length(label);
    times = [[label{:,2}]',[label{:,3}]'];
    table = zeros(n_activities,3);
    for i = 1:n_activities
        win = window(times(i,2) - times(i,1) + 1);
        for j = 1:3
            table(i,j) = max(abs(fftshift(fft(detrend(data(times(i,1):times(i,2),j)).*win))));
        end
    end
    %figure();
   
    % Getting labels
    labels = string(label);
    labels = labels(:,1);
    % Gettting label indexes
    walk_index = find(labels == "W");
    walku_index = find(labels == "W\_U");
    walkd_index = find(labels == "W\_D");
    %sit_index = find(labels == "SIT");
    %lay_index = find(labels == "LAY");
    %stand_index = find(labels == "STAND");
    % Plotting
    plot3(table(walk_index,1),table(walk_index,2),table(walk_index,3),"bo",'DisplayName',"WALK");
    hold on
    plot3(table(walku_index,1),table(walku_index,2),table(walku_index,3),"ro",'DisplayName',"WALK_U_P");
    plot3(table(walkd_index,1),table(walkd_index,2),table(walkd_index,3),"go",'DisplayName',"WALK_D_O_W_N");
    %plot3(table(stand_index,1),table(stand_index,2),table(stand_index,3),"bx",'DisplayName',"STAND");
    %plot3(table(sit_index,1),table(sit_index,2),table(sit_index,3),"rx",'DisplayName',"SIT");
    %plot3(table(lay_index,1),table(lay_index,2),table(lay_index,3),"gx",'DisplayName',"LAY");
    % Title
    title('Tridimensional max DFT plot ['+exp_usr_name+']','Interpreter',"none")
    % Max DFT values in the signal:
    xlabel('ACC_X')
    ylabel('ACC_Y')
    zlabel('ACC_Z')
    legend show
end