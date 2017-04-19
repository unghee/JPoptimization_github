
clear all;
%% Import data from text file.
% Script for importing data from the following text file:
%
%    /home/jordan/Documents/Research/matlabfolder/mech.dat
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/08/24 17:10:49

%% Initialize variables.
% filename = '/scratch/engin_flux/unghee/chemkin/mechanisms/mech_ERC-MultiChem+Bio_Brakora2012.inp';
currentFolder = pwd;
cd(pwd);
% cd mechanisms/;
% filename = 'mech_ERC-MultiChem+Bio_Brakora2012_base.inp';
filename = 'MFC_afteroptimize_2_iteration.inp';
delimiter = ' ';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
% formatSpec = '%s%s%s%s%s%s%s%s%s%[^\n\r]';
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));


%% Split data into numeric and cell columns.
rawNumericColumns = {};
rawCellColumns = raw(:, [1,2,3,4,5,6,7,8,9]);


 %% Replace non-numeric cells with NaN

[A,B]= find(ismember(rawCellColumns,'ELEMENTS'));

locationClass = [A B];

[rowCellNumber,] = size(rawCellColumns);

rawCellColumns2=rawCellColumns;

ModStart = 0;

mechanism='MFC';
fuel_name='n_dodecane';
date = '04_12_2017';
iteration_numb = 3;
class_numb=[11 22 24 26 27];
% class_numb=classnumb;
numbOfClass = length(class_numb);
class_numb_text = {};
for k=1:numbOfClass
%     classnumb_text{classnumb(k)}=['class',num2str(classnumb(k))];
    class_numb_text=[class_numb_text ['class',num2str(class_numb(k))]];
end
pressure=[20 40];
equi=1;
for k=1:length(pressure)
    pressure_text{k}=[num2str(pressure(k)),'atm'];

end
load final_result.mat


for i=1 : rowCellNumber
    [ ~, columnCellNumber] = size(rawCellColumns(i,:));
%     for j= 1 : cellfun('length',rawCellColumns{i,:})
         for j= 1 : 1: columnCellNumber
        
              if strmatch('reactions',rawCellColumns{i,j})==1;
            ModStart = 1;    
              end  
              
              
              for k = 1: numbOfClass
%                if   class_numb(k) == 1 & (strfind(rawCellColumns{i,j},'nc7h16+h=') == 1)... % n heptane erc
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1)...
%                      |(class_numb(k) == 2 & (strfind(rawCellColumns{i,j},'nc7h16+oh=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...
%                      |(class_numb(k) == 3 & (strfind(rawCellColumns{i,j},'nc7h16+ho2=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...
%                      |(class_numb(k) == 4 & (strfind(rawCellColumns{i,j},'nc7h16+o2=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...
%                      |(class_numb(k) == 5 & (strfind(rawCellColumns{i,j},'c7h15-2+o2=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...
%                      | class_numb(k) == 6 & (strfind(rawCellColumns{i,j},'c7h15o2+o2=') == 1)... % n heptane erc
%                      & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1)...
%                      |(class_numb(k) == 7 & (strfind(rawCellColumns{i,j},'c7ket12=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...                     
%                      |(class_numb(k) == 8 & (strfind(rawCellColumns{i,j},'c5h11co=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...    
%                      |(class_numb(k) == 9 & (strfind(rawCellColumns{i,j},'c7h15-2=') == 1)...
%                          & isempty((strfind(rawCellColumns{i},'!')) == 0)& (ModStart == 1))...              
                if  class_numb(k) == 27 & (strfind(rawCellColumns{i,j},'C12OOH') ~= 0)... % n dodecane ske_361
                         & (isempty(strfind(rawCellColumns{i,j},'O2=C12KET')) == 0)...
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...   
                      |class_numb(k) == 21 & (strfind(rawCellColumns{i,j},'NC12H26+H=C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'NC12H26+H=C12H25')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)... 
                      |class_numb(k) == 22 & (strfind(rawCellColumns{i,j},'NC12H26+OH=C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'NC12H26+OH=C12H25')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)... 
                      |class_numb(k) == 23 & (strfind(rawCellColumns{i,j},'NC12H26+O=C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'NC12H26+O=C12H25')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...                          
                      |class_numb(k) == 24 & (strfind(rawCellColumns{i,j},'NC12H26+HO2=C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'NC12H26+HO2=C12H25')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...                       
                     |class_numb(k) == 11 & (strfind(rawCellColumns{i,j},'C12H25') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'+O2=C12H25O2')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)... 
                     |class_numb(k) == 28 & (strfind(rawCellColumns{i,j},'C12KET') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'=OH+')) == 0)...
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...                      
                     |class_numb(k) == 26 & (strfind(rawCellColumns{i,j},'C12OOH') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'O2=C12OOH')) == 0)...
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...
                     |class_numb(k) == 15 & (strfind(rawCellColumns{i,j},'C12H25O2') ~= 0)... 
                         & (isempty(strfind(rawCellColumns{i,j},'=C12OOH')) == 0)...
                         & (isempty(strfind(rawCellColumns{i,j},'-1')) == 1)... %except -1 reaction
                         & (isempty(strfind(rawCellColumns{i,j},'C12OOH6-3')) == 1)...
                         & (isempty(strfind(rawCellColumns{i,j},'C12OOH6-9')) == 1)...
                         & (isempty(strfind(rawCellColumns{i},'!')) == 1)& (ModStart == 1)...       
                  
                  rawCellColumns2{i,9} =  ['!***ClASS',num2str(class_numb(k)),'***','after Optimize'];
            
                  rawCellColumns2{i,2} = final_result.(class_numb_text{k})(2,1);  % Optimized A
                  rawCellColumns2{i,4} = final_result.(class_numb_text{k})(2,2); % Optimized E
        
                
               end
              end
         end
end 
         
%%
% datename = '01_19_2017'
% save_filename=[mechanism,'_','output','_',datename];


save_filename='output';

for k = 1 :length(pressure)
directory=['C:\Users\unghee\Dropbox\post_process','\',mechanism,'\',fuel_name,'_',pressure_text{k},'_','phi',num2str(equi),'_',date];
% location=[currentloc,'\',mechanism,'\',directory];
cd(directory)

mkdir(save_filename);
cd(save_filename);

class_numb_text = [];
for k=1:numbOfClass
%     classnumb_text{classnumb(k)}=['class',num2str(classnumb(k))];
    class_numb_text=[class_numb_text '_' ['class',num2str(class_numb(k))]];
end
% file_name=[mechanism,'_',fuel_name,class_numb_text,'_','afteroptimize','.inp'];
file_name=[mechanism,'_','afteroptimize','_',num2str(iteration_numb),'_','iteration','.inp'];
fileID = fopen(file_name,'w');
output = cell(size(rawCellColumns2,1),size(rawCellColumns2,2));



    for i = 1:size(rawCellColumns2,1)
     for j = 1:size(rawCellColumns2,2)
         if numel(rawCellColumns2{i,j}) == 0
            output{i,j} = '';
            % Check whether the content of cell i,j is
            % numeric and convert numbers to strings.
         elseif isnumeric(rawCellColumns2{i,j}) || islogical(rawCellColumns2{i,j})
            output{i,j} = num2str(rawCellColumns2{i,j}(1,1));
            
            % If the cell already contains a string, nothing has to be done.
         elseif ischar(rawCellColumns2{i,j})
            output{i,j} = rawCellColumns2{i,j};
         end;
        
        % Cell i,j is written to the output file. A delimiter is appended for
        % all but the last element of each row. At the end of a row, a newline
        % is written to the output file.
         if j < size(rawCellColumns2,2)
            fprintf(fileID,['%s',delimiter],output{i,j});
          else
            fprintf(fileID,'%s\r\n',output{i,j});
         end
     end;
    end;


fclose(fileID);

end
% exit
%type mech_ERC-MultiChem+Bio_Brakora2012_v1_test.inp

%% Clear temporary variables
% clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawCellColumns rawNumericColumns R;