%% ps7

vid = VideoReader('input/PS7A1P1T1.avi');
k=1;
while hasFrame(vid)
    frame1 = readFrame(vid);
    if k == 10 
        bimg = binary_sequence(frame0,frame1,15);
        imwrite(255.*uint8(bimg), 'output/ps7-1-a-1.png');
    end
    if k == 20
        bimg = binary_sequence(frame0,frame1,15);
        imwrite(255.*uint8(bimg), 'output/ps7-1-a-2.png');
    end
    if k == 30
        bimg = binary_sequence(frame0,frame1,15);
        imwrite(255.*uint8(bimg), 'output/ps7-1-a-3.png');
        break;
    end
    k = k +1;
    frame0 = frame1;
end

vid = VideoReader('input/PS7A1P1T1.avi');
MHIA1 = computeMHI(vid);
imwrite(uint8(round(MHIA1)), 'output/ps7-1-2-1.png');

vid = VideoReader('input/PS7A2P1T1.avi');
MHIA1 = computeMHI(vid);
imwrite(uint8(round(MHIA1)), 'output/ps7-1-2-2.png')

vid = VideoReader('input/PS7A3P1T1.avi');
MHIA1 = computeMHI(vid);
imwrite(uint8(round(MHIA1)), 'output/ps7-1-2-3.png')

%% 2a

%% ps7test

vid = VideoReader('input/PS7A1P1T1.avi');

[MA1,NA1] = getClassMatrix(vid);


vid = VideoReader('input/PS7A2P1T1.avi');

[MA2,NA2] = getClassMatrix(vid);


vid = VideoReader('input/PS7A3P1T1.avi');

[MA3,NA3] = getClassMatrix(vid);

instancesM = scaleDims([MA1;MA2;MA3]);

instancesN = scaleDims([NA1;NA2;NA3]);
featersN = size(MA1,2);
testingInstancesforM = zeros(27,featersN);
testingInstancesforN = zeros(27,featersN);
k = 1;
test_labels = zeros(27,1);
subject_labels = zeros(27,1);
for subject = 1:3
    for action = 1:3
        for trial = 1:3
            string1 = strcat(num2str(subject));
            string2 = strcat(num2str(action));
            string3 = strcat(num2str(trial));
            
            vid  = VideoReader(strcat('input/PS7A',string2,'P',string1,'T',string3,'.avi'));
            
           [MA,NA] = getClassMatrix(vid);
           
           testingInstancesforM(k,:)=MA;
           testingInstancesforN(k,:)=NA;
           test_labels(k,1) = action;
           subject_labels(k,1) = subject;
           k = k+1;
        end
    end
end
testingInstancesforM= scaleDims(testingInstancesforM);
confusionM = computeConfusion(testingInstancesforM,instancesM,test_labels);

testingInstancesforN = scaleDims(testingInstancesforN);
confusionN = computeConfusion(testingInstancesforN,instancesN,test_labels);

confusionMsub1 = computeConfusionSubject(testingInstancesforM,instancesM,test_labels,1,subject_labels);

confusionMsub2 = computeConfusionSubject(testingInstancesforM,instancesM,test_labels,2,subject_labels);

confusionMsub3 = computeConfusionSubject(testingInstancesforM,instancesM,test_labels,3,subject_labels);



confusionNsub1 = computeConfusionSubject(testingInstancesforN,instancesN,test_labels,1,subject_labels);

confusionNsub2 = computeConfusionSubject(testingInstancesforN,instancesN,test_labels,2,subject_labels);

confusionNsub3 = computeConfusionSubject(testingInstancesforN,instancesN,test_labels,3,subject_labels);

 averagedM = (confusionMsub1 + confusionMsub2 + confusionMsub3)./3;
  averagedN = (confusionNsub1 + confusionNsub2 + confusionNsub3)./3;