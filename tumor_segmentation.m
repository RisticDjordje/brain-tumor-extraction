image = cjdata.image; 
image_contrasted = imadjust(image);

image_lpf = medfilt2(image_contrasted);
stronger_edges = image_contrasted - image_lpf;
image_merged = image_contrasted + stronger_edges;

T = adaptthresh(image_merged);
bw = image_merged>(2*T);

SE = strel('disk', 4);
erode = imerode(bw,SE);
SE = strel('disk', 2);
dilate = imdilate(erode,SE);

logical = int16(dilate*(2^16-1));
sobel = edge(logical); 
fill = imfill(sobel, 'holes');

number_of_white_px = nnz(fill);
image_without_small_objects = bwareaopen(fill, round(number_of_white_px/10));
regions = find_all_regions(image_without_small_objects);
regions_size = size(regions);
img_without_skull = image_without_small_objects;

for i=1: regions_size(1)
    number = nnz(regions(i, :, 1));
    max_x = max(regions(i, :, 1));
    max_y = max(regions(i, :, 2));
    min_x = regions(i, 1, 1);
    min_y = regions(i, 1, 2);
    for j = 2:number  
        if regions(i, j, 1) < min_x
            min_x = regions(i, j, 1);
        end
        if regions(i, j, 2) < min_y
            min_y = regions(i, j, 2);
        end
    end
    surface = (max_x - min_x) * (max_y - min_y);
    density = number / surface;
    if density < 0.3
        for k = 1 : regions_size(2)
            if regions(i, k, 1) ~= 0 && regions(i, k, 2) ~= 0
                img_without_skull(regions(i, k, 1), regions(i, k, 2)) = 0;
            end
        end
    end
end

final_regions = find_all_regions(img_without_skull);
final = img_without_skull;
final_size = size(final_regions);

br = 0;
for i=final_size(1): -1:1
    number = nnz(final_regions(i, :, 1));
    if number > 0
        br = br + 1;
        if br >= 2
            for j = 1:number  
                for k = 1 : final_size(2)
                    if final_regions(i, k, 1) ~= 0 && final_regions(i, k, 2) ~= 0
                        final(final_regions(i, k, 1), final_regions(i, k, 2)) = 0;
                    end
                end
            end
        end
    end
end

imshow(final)
