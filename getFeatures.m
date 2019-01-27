function [All_features] = getFeatures(trn,VR,mode)


%% Removing oultiers
if strcmp(mode,'training')
    trn = remoutl(trn,2);
    lab = getlabels(trn);

%% get Zernike moments for training and testing
m_trn_zer = im_moments(trn,'zer',12);
[m_trn_zer,w_zer] = NormPCA(m_trn_zer);

%% get hu moments for training and testing
m_trn_hu = im_moments(trn,'hu',12);
[m_trn_hu, w_hu] = NormPCA(m_trn_hu);

%% get statistics for training and testing
m_trn_stat = im_stat(trn);
[m_trn_stat, w_stat] = NormPCA(m_trn_stat);

%% get HOG features
cellSize = [2 2];
m_trn_HOG = getHOGFeatures(trn,cellSize);
[m_trn_HOG, w_HOG] = NormPCA(m_trn_HOG);

%% Skeleton-based features
m_trn_skel = im_skel_meas(trn);
[m_trn_skel, w_skel] = NormPCA(m_trn_skel);

%% Harris corner detector - features
m_trn_har = im_harris(trn);
[m_trn_har, w_har] = NormPCA(m_trn_har);


All_features = [m_trn_zer m_trn_hu m_trn_stat  m_trn_skel m_trn_har m_trn_HOG ];
w_norm = scalem(All_features,'c-variance');

save('feature_map_pca','w_zer','w_hu','w_stat','w_skel','w_har','w_HOG','w_norm')

else
load('feature_map_pca')

%% get Zernike moments for training and testing
m_trn_zer = im_moments(trn,'zer',12);
m_trn_zer = m_trn_zer*w_zer;

%% get hu moments for training and testing
m_trn_hu = im_moments(trn,'hu',12);
m_trn_hu = m_trn_hu*w_hu;

%% get statistics for training and testing
m_trn_stat = im_stat(trn);
m_trn_stat = m_trn_stat*w_stat;

%% get HOG features
cellSize = [2 2];
m_trn_HOG = getHOGFeatures(trn,cellSize);
m_trn_HOG = m_trn_HOG*w_HOG;

%% Skeleton-based features
m_trn_skel = im_skel_meas(trn);
m_trn_skel = m_trn_skel*w_skel;

%% Harris corner detector - features
m_trn_har = im_harris(trn);
m_trn_har = m_trn_har*w_har;
    
All_features = [m_trn_zer m_trn_hu m_trn_stat  m_trn_skel m_trn_har m_trn_HOG ];

end

All_features =  All_features*w_norm;

function [m_trn, w] = NormPCA(m_trn)

[w_pca, ~] = pcam(m_trn,VR);
w = w_pca;
m_trn = m_trn*w_pca;

end

end