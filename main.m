%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             Pattern recognition              %%
%%             Final assignment                 %%
%%                                              %% 
%%             Casper Athmer - xxxxxx           %% 
%%             Cas Bilstra   - xxxxxx           %%
%%             Peter Jamar   - 4128486          %%
%%                                              %%
%%             January 2019                     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Initialazation

setup;                                      % This file should load the paths to the course files
prwaitbar off;

if isfile('workspace_ini.mat')           % Check if data can be loaded from file, otherwise create data
    load('workspace_ini.mat');
else
    a = prnist([0:9],[1:100:1000]); %figure(1); show(a);
    b = preprocessing(a); %figure(2); show(b);
    save('workspace_ini.mat')
end


%% Training & Classification

rep = input('Choice of representation: pixel[1] feature[2] dissimilarities[3]    ');

switch rep
    
    case 1                                  % pixel representation
        w = svc(b);                         % Trains a support vector machine
        labels = b*w*labeld;                % Shows the labels that the classifier assigns to objects from b
             
    case 2                                  % feature representation

         
    case 3                                  % dissimilarities representation
end

%% Evaluation

% Evaluate the performance of the classifier
% e = nist_eval('preprocessing', w, 10);
% disp(e);

%Uncomment this to see how rotation influences the images
%rotation(a);

%pixelclassification(a);
