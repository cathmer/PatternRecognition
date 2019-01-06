function W = trainClassifier(trn,clsf,sampleSizes,combiner)

randreset;
state = randreset;

% If multiple training sets are given as input, the first each training set
% is trained with the classifier and these mappings are combined with the
% specified combiner.
if iscell(trn)
    if ~exist('combiner','var')
        error("No combiner specified");
        return;
    end
    
    for i=1:length(sampleSizes)
        sizes = sampleSizes(i) .* ones(1,10);
        wCombined = [];
        for j=1:size(trn,2)
            a = gendat(trn{j},sizes,state);
            w = a*clsf;
            wCombined = [wCombined; w];
        end
        
        if iscell(combiner)
            for j=1:length(combiner)
                W{j,i} = wCombined*combiner;
            end
        else
            W{i} = wCombined*combiner;
        end
    end
% In this case there is one training set and one classifier, and no
% combining is done.
else
    for i=1:length(sampleSizes)
        sizes = sampleSizes(i) .* ones(1,10);
        a = gendat(trn,sizes,state);        
        W{i} = a*clsf;
    end
end