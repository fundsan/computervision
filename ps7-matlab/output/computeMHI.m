function MHI = computeMHI(vid)

frameN =1;
while(hasFrame(vid))
    frames(:,:,:,frameN) = readFrame(vid);
    frameN = frameN +1;
end
startFrame = round(frameN*.25);
finishFrame = round(frameN*.75);
prevMHI = ones(size(frames,1),size(frames,2),'double');
prevFrame = frames(:,:,:,startFrame-1);
interval= 255/(finishFrame-startFrame);
totalTnterval = interval;
for t = startFrame:finishFrame
    frame = frames(:,:,:,t); 
    
    binaryImg= binary_sequence(prevFrame, frame, 15);
    MHI = getMHI(binaryImg, prevMHI, totalTnterval);
    
    totalTnterval= totalTnterval+interval ;
    prevMHI = MHI;
    prevFrame = frame;
   
end