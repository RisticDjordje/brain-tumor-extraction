function [regions] = find_all_regions(img)
    
    regions = zeros(100,2000,2);

    pic_size = size(img);
    curr_ind = 1;
    
    for i= 1 : pic_size(1)
        for j = 1:pic_size(2)
            if  img(i,j) == 1
                region = bfs(img, i, j);
                region_size = size(region);
               
                regions(curr_ind,1:size(region,1),:) = region;
                
                curr_ind = curr_ind + 1;
                
                for h = 1 : region_size(1)
                    img(region(h,1), region(h,2)) = 0;
                end
            end
        end
    end

end