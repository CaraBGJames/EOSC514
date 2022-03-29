
vidObj = VideoReader('circle_push_nooil.mp4');

%30fps, 2160x3840, RGB24

t1=5;         %time in seconds - marks the beginning of the portion of the movie I want to analyse
t2=48;%time in seconds - marks the end of the portion of the movie I want to analyse
t3 = 24; %time it turns around
t4 = 35;
t5 = 43;

framerate=30;
m=ceil(t1*framerate);
n=ceil(t2*framerate);
hei = 1200:2600;
wid = 200:1900;
se = strel('disk',15);

%% testing/show process

test=read(vidObj,m); %get frame you want
imshow(test); %pick what selection of pixels you want

test1 = test(hei,wid,1); %Only take red channel (dye shows up best)

test2 = test1<25; %take darkest pixels

se = strel('disk',15); 
test3 = imclose(test2,se); %binary erosion and dilation to merge big blobs
%imshow(closeBW);

test4 = bwareafilt(test3,3);
%imshow(x5);

test5 = imoverlay(test1, test4, 'red');
imshow(test5)

%% looping 

blob_size = [];

t_arr = [];
t = 0;
dt = 10;
count = 1;
for k = m:dt:n
    
    x2=read(vidObj,k); %get frame
    x3 = x2(hei,wid,1); %smaller area, only red channel
    x4 = x3<25;
    x4 = imclose(x4,se);
    x5 = bwareafilt(x4,1); %only keep 1 biggest blob
    areas = struct2array(regionprops(x5, 'area')); %get area of blob(s)
    
    for i = 1:length(areas)
        blob_size(count,i) = areas(i);
    end

    t_arr = [t_arr, t];
    t = t + dt/framerate;
    
    count = count + 1;

end


%% Plotting

norm_blob = blob_size./blob_size(1,:);

norm_blob_d = sqrt(blob_size)/sqrt(blob_size(1,:));

plot(t_arr, norm_blob_d)
hold on
plot(t_arr, norm_blob)
xline(t3-t1, '--k','Pull back')
%xline(t4-t1, '--k','Push again')
%xline(t5-t1, '--k','Pull again')
hold off

title('Square, oiled, push')
xlabel('time after start pushing / s')
ylabel('blob area/initial blob area')
legend('diameter', 'area', 'change dir')