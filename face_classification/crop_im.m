gender = {'male', 'female'};
mkdir male_data
mkdir female_data

for gend=1:2
    train = zeros(32,32, 260);
    for i=1:260
        im = imread(sprintf('../../train_data/%s/image_%03d.jpg', char(gender(gend)), i));
        load(sprintf('../../train_data/%s/image_%03d.mat', char(gender(gend)), i));
        face_im = im(min(y(1), y(2))-25:y(4)+25, x(1)-15:x(2)+15,:);
        face_im = double(rgb2gray(face_im));
        face_im = imresize(face_im, [32, 32]);
        train(:,:, i) = face_im;
    end
    save(sprintf('%s_train.mat', char(gender(gend))), 'train');
end

train_images = zeros(32,32,520);
load('female_train')
train_images(:,:,1:260) = train;
load('male_train')
train_images(:,:,261:520) = train;
delete female_train.mat male_train.mat
labels = zeros(520, 1);
labels(261:520) = 1;
identity = zeros(520,1);
for i=1:520
    identity(i) = i;
end
save('train_data.mat', 'labels', 'train_images', 'identity')
clear all