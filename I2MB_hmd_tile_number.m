function [ tiles, tile_num ] = I2MB_hmd_tile_number( user,video )
%HMD_TILE_NUMBER Summary of this function goes here
%   Detailed explanation goes here
hmd = evalin('base', 'HMD_data');
vi=hmd{user,video};
tiles=zeros(size(vi,1),2);
tile_num=zeros(size(vi,1),1);
for i=1:(size(vi,1))
    vi_val=vi(i,1);
    for j=1:4
        if(vi_val>=((j-1)*(180/4)))
            tiles(i,1)=4+j;
        end
        if(vi_val<=(-(j-1)*(180/4)))
            tiles(i,1)=4-j;
        end
    end
   vi_val=vi(i,2);
    for j=1:4
        if(vi_val>=((j-1)*(180/4)))
            tiles(i,2)=4+j;
        end
        if(vi_val<=(-(j-1)*(180/4)))
            tiles(i,2)=4-j;
        end
    end
    tile_num(i,1)=8*(tiles(i,1)-1)+tiles(i,2);
end

