%% Show multi-spectral images
function myshowRGB(rgb_image)

if size(rgb_image,3)==1
    channel = [1];
    frame = 1;
elseif size(rgb_image,3)==4
    channel = [3 2 1];
    frame = 1;
elseif size(rgb_image,3)==8
    channel = [5 3 2];
    frame = 1;
end

th_MSrgb = image_quantile(rgb_image(:,:,channel,frame),[0.01,0.99]);
I_fuse = image_stretch(rgb_image(:,:,channel,frame),th_MSrgb);
imshow(I_fuse,[])

end