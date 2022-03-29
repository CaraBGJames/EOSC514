file_loc = '/Users/cjames/Library/CloudStorage/OneDrive-UBC/PhD/Experiments/2022_03_27/nooil_1fps/';

l = 19;
framename = [file_loc,'nooil_frame_', num2str(l,'%04.f'),'.jpg'];
b = imread(framename);
b1 = b(210:850,610:1250,3);

for k = 20:1798
    framename = [file_loc,'nooil_frame_', num2str(k,'%04.f'),'.jpg'];
    f = imread(framename);
    f1 = f(210:850,610:1250,3);
    f2 = b1-f1;
    sl = f2(270:330,:);
    sl1 = sum(sl,1);
    sl2 = smooth(sl1, 10);
    a = findchangepts(sl2,'MaxNumChanges',10);
    a1 = [min(a),max(a)];
    edges(k-18,:) = a1;
end


%%
time = 29:1798;
l_time = log(time);

plot(l_time, l_oil)
hold on
plot(l_time(1:1273), l_nooil)
hold off
