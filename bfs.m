function output_arr = bfs(img, x,y)

    start_val = img(x,y);
    pic_size = size(img);

    arr = [x,y];
    curr_ind = 1;
    curr_size = size(arr);
    
    while curr_ind <= curr_size(1)
        curr_point = arr(curr_ind, :);
        
        if curr_point(1) > 1
            if sum(arr(:, 1) == curr_point(1)-1 & arr(:, 2) == curr_point(2)) == 0
                if img(curr_point(1)-1, curr_point(2)) == start_val
                    arr = [arr ; [curr_point(1)-1, curr_point(2)]];
                end
            end
        end
        
        if curr_point(1) < pic_size(1)
            if sum(arr(:, 1) == curr_point(1)+1 & arr(:, 2) == curr_point(2)) == 0
                if img(curr_point(1)+1, curr_point(2)) == start_val
                    arr = [arr ; [curr_point(1)+1, curr_point(2)]];
                end
            end
        end
        
        if curr_point(2) > 1
            if sum(arr(:, 1) == curr_point(1) & arr(:, 2) == curr_point(2)-1) == 0
                if img(curr_point(1), curr_point(2)-1) == start_val
                    arr = [arr ; [curr_point(1), curr_point(2)-1]];
                end
            end
        end
        
        if curr_point(2) < pic_size(2)
            if sum(arr(:, 1) == curr_point(1) & arr(:, 2) == curr_point(2)+1) == 0
                if img(curr_point(1), curr_point(2)+1) == start_val
                    arr = [arr ; [curr_point(1), curr_point(2)+1]];
                end
            end
        end
                
        curr_ind = curr_ind + 1;
        curr_size = size(arr);
        
    end
    
    output_arr = arr;
    
end