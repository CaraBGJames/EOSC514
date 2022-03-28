vid1 = VideoReader('oil_30fps_1.MP4');
vid2 = VideoReader('oil_30fps_2.MP4');

l = round(vid1.Duration + vid2.Duration); %length in seconds
fr = 30;

for k = round(vid1.Duration)+1:l
    framename = ['oil_1fps/oil_frame_', num2str(k,'%04.f'),'.jpg'];
    if k <= round(vid1.Duration)
        f = k*fr;
        x = read(vid1,f);
        imwrite(x, framename, 'quality',100);
    else
        f = (k-round(vid1.Duration))*fr;
        x = read(vid2,f);
        imwrite(x, framename, 'quality',100);
    end

    if rem(k,fr) == 0
        disp((k/l)*100);
    end
end

%%

writerObj = VideoWriter('oil_1fps');
writerObj.FrameRate = 20;
open(writerObj);

for k = 1:l
    imagename = ['oil_1fps/oil_frame_', num2str(k,'%04.f'),'.jpg'];
    I = imread(imagename);
    writeVideo(writerObj, I);
    if rem(k,100) == 0
        disp(k*100/l);
    end
end
close(writerObj)