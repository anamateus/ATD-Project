function get_labels(labels,activities,experiments,users)
	% ==================== get_labels  ====================
	% This function receives que labels data that was located in the
	% labels.txt file and returns a cell array with 3 columns. The first
	% column is a string that identifies the activity that the user was
	% doing at a given moment in time. The second column contains the
	% start time of each activity in the dataset ( keeping in mind
	% that those times are associated with the samples that were 
	% obtained with a sampling frequency of 50Hz). The last column
	% contains the activities ending time.
	% This cell array will be useful to identify each activity in the
	% correspondent dataset. The function loads the cell array to the
	% workspace with the same name of the entry file with an extra
	% "_label" to distiguish the dataset with the labeling
	% Arguments :
	%			>>> labels: The matrix that is obtained
	%			from the labels.txt file  (check the docs
	%			folder to know more obout the labels.txt
	%			file structure)
	%			>>> activities: An array with all the
	%			strings associated with the labels ids
	%			>>> experiments : Array with the experiment 
	%			numbers of themultiple datasets that were 
	%			loaded to the workspace
	%			>>> users: Array with the user ids associated with
	%			the experiment numbers.
	% =================================================

	k = 1;
	format = "exp%.2d_usr%.2d_label";
	for  exp = experiments(2:2:end)
		usr_exp_1 = find(labels(:,1) == (exp - 1))';
		usr_exp_2 = find( labels(:,1) == exp)';
		
		l1 = label_activities(activities,labels(usr_exp_1,3:5));
		l2 = label_activities(activities,labels(usr_exp_2,3:5));
		
		assignin("base",sprintf(format,exp - 1,users(k)),l1);	
		assignin("base",sprintf(format,exp,users(k + 1)),l2);
		k = k + 2;
	end
end

function out = label_activities(activities,labels)
	% helper function just to put the labels in the activities
	out = num2cell(labels);
	for  k = 1 : length(labels)
		out(k,1) = {activities(labels(k,1))};
	end
end