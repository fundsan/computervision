function trackedVid = run_particle_appearance(video,particle_n, patch,sigma,dist_sig, noise_sigma, a, name)
    [ypatch,xpatch,zpatch] = size(patch);
    vidHeight = video.Height;
    vidWidth = video.Width;
 mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);

k =1;
rng(0,'twister');
particle_y = round(normrnd(450,dist_sig,[1 particle_n]))';
particle_x =  round(normrnd(576,dist_sig,[1 particle_n]))';
weights = ones(particle_n)./particle_n;
S = [particle_y,particle_x,weights];
writerObj = VideoWriter(name);
writerObj.FrameRate = video.FrameRate;
open(writerObj);
while hasFrame(video)
    mov(k).cdata = readFrame(video);
   
    
   [S, particle_patch]= particle_filter_appearance(S,mov(k).cdata,sigma,dist_sig,noise_sigma,patch);
   patch = convertTo256Img(a .*(double(patch) + ((1-a).*double(particle_patch))));
   [bestPart,I] = max(S(:,3));
   ypart = S(I,1);
   xpart= S(I,2);
   bestCords = [(ypart - ceil(ypatch/2)),ypart + floor(ypatch/2),xpart - ceil(xpatch/2),xpart + floor(xpatch/2)];
   
   frame = drawParticlesAndRectangle(mov(k).cdata,S(:,1:2),bestCords);
   writeVideo(writerObj,frame);
   k = k+1;
end
close(writerObj);
trackedVid = writerObj; 
end