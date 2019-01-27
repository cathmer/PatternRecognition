trn = setprior(trn,getprior(trn));




%% Get features
VR = 0.97;
All_features_trn = getFeatures(trn,VR,'training');

%% Scaled features + floating ffs
[N, M] = size(All_features_trn);

% Calculate the correlation matrix of the features
h = All_features_trn;
cor = h'*h./(N*std(h)'*std(h)) ;

%%
x_trn = All_features_trn;
iter  = 1;
trainsize = [1000];
featsize = [58:1:62];
N = prmemory(100000000);
randreset;
e1 = cell(1,numel(trainsize));
for i = 3
    if i == 1
        Classf = fisherc([]);
    elseif i == 2
        Classf = qdc([]);
    elseif i == 3
        Classf = parzenc([]);
    elseif i == 4
        Classf = knnc([],5);
    elseif i == 5
        Classf = naivebc([],15);
    end
for j=1:length(trainsize)  
  e1{i,j} = clevalf(x_trn,Classf,featsize,ones(1,10)*trainsize(j),iter,[],testd);
  disp([num2str(i), ',' , num2str(j)])
end
end

%%

Classf = parzenc([]);
N = prmemory(100000000);
w_fs = featsel(size(All_features_trn,2),1:68);

w_scenario2 = w_fs*w;