data = prnist([0:9],[1:50:1000]);
a = preprocess_dissim(data);

% 10 images per class in dtr, 10 images per class in dte
[dtr, dte] = genddat(a,0.5);
    
%% k-NN
k = pe_knnc(dtr,1);
e_test = testc(dte,k);
% number 10 should be here, because trained with 10 images per class. WHY!!
e_nist = nist_eval('preprocess_dissim', k, 10);
