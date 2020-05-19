function power_3d_plot(exp_usr_name)
    sensors = ["ACC\_X","ACC\_Y","ACC\_Z"];
    % Getting Workspace Variables
    label_name = sprintf("%s_label",exp_usr_name);
    label = evalin('base',label_name);
    % Aux vars
    n_activities = length(label);
   
    table = signal_power(exp_usr_name,1:n_activities,sensors,false);

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
    % Dinamic
    if ~isempty(walk_index)
        plot3(table(walk_index,1),table(walk_index,2),table(walk_index,3),"bo",'DisplayName',"WALK");
    end
    hold on
    if ~isempty(walku_index)
        plot3(table(walku_index,1),table(walku_index,2),table(walku_index,3),"ro",'DisplayName',"WALK_U_P");
    end
    if ~isempty(walkd_index)
        plot3(table(walkd_index,1),table(walkd_index,2),table(walkd_index,3),"go",'DisplayName',"WALK_D_O_W_N");
    end
    % Static
    if ~isempty(stand_index)
        plot3(table(stand_index,1),table(stand_index,2),table(stand_index,3),"bx",'DisplayName',"STAND");
    end
    if ~isempty(sit_index)
        plot3(table(sit_index,1),table(sit_index,2),table(sit_index,3),"rx",'DisplayName',"SIT");
    end
    if ~isempty(lay_index)
        plot3(table(lay_index,1),table(lay_index,2),table(lay_index,3),"gx",'DisplayName',"LAY");
    end
    % Transitions
    if ~isempty(stsit)
        plot3(table(stsit,1),table(stsit,2),table(stsit,3),"y*",'DisplayName',"Stand->Sit");
    end
    if ~isempty(ststand)
        plot3(table(ststand,1),table(ststand,2),table(ststand,3),"y+",'DisplayName',"Sit->Stand");
    end
    if ~isempty(sittl)
        plot3(table(sittl,1),table(sittl,2),table(sittl,3),"yx",'DisplayName',"Sit->Lay");
    end
    if ~isempty(ltsit)
        plot3(table(ltsit,1),table(ltsit,2),table(ltsit,3),"c*",'DisplayName',"Lay->Sit");
    end
    if ~isempty(standtl)
        plot3(table(standtl,1),table(standtl,2),table(standtl,3),"c+",'DisplayName',"Stand->Lay");
    end
    if ~isempty(ltstand)
        plot3(table(ltstand,1),table(ltstand,2),table(ltstand,3),"cx",'DisplayName',"Lay->Stand");
    end
    % Title
    title("Power of " + exp_usr_name,'Interpreter','none')
    xlabel('ACC_X')
    ylabel('ACC_Y')
    zlabel('ACC_Z')
    legend show;
end