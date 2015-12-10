function confusion = computeConfusionSubject(testing,trained, test_labels,subject, subject_labels)
    actionsN = size(trained,1);
    instancesM = size(testing,1);
    confusion = zeros(actionsN,actionsN);
    testLabelsN = zeros(actionsN,1);
    for a = 1:actionsN
        testLabelsN(a,1) = sum(test_labels == a & subject_labels == subject);
    end
    for m = 1:instancesM
        if ~(subject_labels(m,1) == subject)
            continue
        end
        
        currentM = testing(m,:);
        bestAction = 0;
        bestTotal = Inf;
        for m2 = 1:instancesM
            if subject_labels(m,1) == subject_labels(m2,1)
                continue
            end
            against = testing(m2,:);
            currentTotal = sum(sum((currentM-against).^2));
            if currentTotal < bestTotal
              bestAction = test_labels(m2,1);
              bestTotal = currentTotal;
            end
        end
        confusion(test_labels(m,1),bestAction) = confusion(test_labels(m,1),bestAction)+1;
    end
    for a = 1:actionsN
        confusion(a,:) = confusion(a,:)./testLabelsN(a,1);
    end 
        
           