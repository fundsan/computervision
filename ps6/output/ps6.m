vid = VideoReader('input/pres_debate.mov');
mov = struct('cdata',zeros(vid.Height,vid.Width,1,'uint8'),...
    'colormap',[]);
frame = readFrame(vid);
mitsHead = frame( (175):(175+130),(321):(321+104),:);
%mitsBigHead = frame( (175):(175+200),(321):(321+104),:);
%mitsSmallHead = frame( (235):(235+86),(351):(351+74),:);
%imwrite(mitsHead, 'output/ps6-1-a-1.png');
%vid = VideoReader('input/pres_debate.mov');
%tracked = run_particle(vid,250,mitsHead, 10, 'debate');
%optimize
%bad results with small sigma
%tracked = run_particle(vid,500,mitsHead, 1, 'debate');
%better results with large sigma, smoothly returns to his face
%tracked = run_particle(vid,500,mitsHead, 20, 'debate');
% takes a little longer to converge but works
%tracked = run_particle(vid,100,mitsHead, 10, 'debate');
% more accurate, needs less particles
%tracked = run_particle(vid,500,mitsBigHead, 10, 'debate');
% faster, accurate, needs less particles
% tracked = run_particle(vid,200,mitsSmallHead, 10, 'debate');
 run_particle(vid,500,mitsHead, 10, 'output/debate');
tracked_vid =VideoReader('output/debate.avi');

k=1;

while hasFrame(tracked_vid)
    frame = readFrame(tracked_vid);
    if k == 28 
        imwrite(frame, 'output/ps6-1-a-2.png');
    end
    if k == 48 
        imwrite(frame, 'output/ps6-1-a-3.png');
    end
    if k == 144 
        imwrite(frame, 'output/ps6-1-a-4.png');
        break;
    end
    k = k +1;
end
vid_noise = VideoReader('input/noisy_debate.mov');

tracked = run_particle(vid_noise,500,mitsHead, 10, 'output/debate_noise');
tracked_vid =VideoReader('output/debate_noise.avi');
k=1;
while hasFrame(tracked_vid)
    frame = readFrame(tracked_vid);
    if k == 14 
        imwrite(frame, 'output/ps6-1-e-1.png');
    end
    if k == 32
        imwrite(frame, 'output/ps6-1-e-2.png');
    end
    if k == 46 
        imwrite(frame, 'output/ps6-1-e-3.png');
        break;
    end
    k = k +1;
end
%writeFrame(VideoReader('debate.avi'));

vid = VideoReader('input/pres_debate.mov');
mov = struct('cdata',zeros(vid.Height,vid.Width,1,'uint8'),...
    'colormap',[]);
frame = readFrame(vid);
mitsHand = frame( 375:495,551:601,:);
imwrite(mitsHand, 'output/ps6-2-a-1.png');
vid = VideoReader('input/pres_debate.mov');
run_particle_appearance(vid,100, mitsHand,2,50,30,.01, 'output/debate_hand');
tracked_vid =VideoReader('output/debate_hand.avi');
k=1;
while hasFrame(tracked_vid)
    frame = readFrame(tracked_vid);
    if k == 15 
        imwrite(frame, 'output/ps6-2-a-2.png');
    end
    if k == 50
        imwrite(frame, 'output/ps6-2-a-3.png');
    end
    if k == 140
        imwrite(frame, 'output/ps6-2-a-4.png');
        break;
    end
    k = k +1;
end

vid_noise = VideoReader('input/noisy_debate.mov');
frame = readFrame(vid_noise);
mitsHand = frame( 405:475,551:591,:);
vid_noise = VideoReader('input/noisy_debate.mov');
imwrite(mitsHand, 'output/ps6-2-b-1.png');
run_particle_appearance(vid_noise,150,mitsHand,10, 10,10,.01, 'output/debate_noise_hand');
tracked_vid =VideoReader('output/debate_noise_hand.avi');
k=1;
while hasFrame(tracked_vid)
    frame = readFrame(tracked_vid);
    if k == 15 
        imwrite(frame, 'output/ps6-2-b-2.png');
    end
    if k == 50
        imwrite(frame, 'output/ps6-2-b-3.png');
    end
    if k == 140 
        imwrite(frame, 'output/ps6-2-b-4.png');
        break;
    end
    k = k +1;
end