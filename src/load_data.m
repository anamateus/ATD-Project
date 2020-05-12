function [exp,usr] = load_data(dir_path)
	% ==================== load_data  ====================
	% Description: This functions takes a directory with .txt files
	% that will be used as dataset and loads the matrices with the
	% data to the matlab workspace.
	% Arguments :
	%		>>> dir_path (string): Path to the directory
	% Return: 
	%		>>> exp : Array with the experiment numbers of the
	%		multiple datasets that were loaded to the workspace
	%		>>> usr: Array with the user ids associated with
	%		the experiment numbers.
	% =================================================
	files = dir(dir_path);
	exp = zeros(size(files(4:end)))';
	usr = zeros(size(files(4:end)))';
	k = 1;
	for file = files(3:end)'
		fpath = sprintf("%s/%s",file.folder,file.name);
		data = importdata(fpath," ");
		if file.name ~= "labels.txt"
			assignin("base",file.name(5:16),data);		
			exp(k) = str2double(file.name(8:9));
			usr(k) = str2double(file.name(15:16));
		else
			assignin("base",sprintf("labels"),data);
		end
			k = k + 1;
	end
end