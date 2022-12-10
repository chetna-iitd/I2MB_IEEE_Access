function [ rate_all,rate_qp,rate_tile,qual_all,qual_qp,qual_tile  ] = Immersive_video_rate_qp( video_index,qp,tile)
%IMMERSIVE_VIDEO_RATE_QP 
v = evalin('base', 'video_bitrate_data');
rate_all=v{1,video_index};
rate_qp(1,:)=rate_all(qp,tile,:);
rate_tile(:,:)=rate_all(:,tile,:);

q = evalin('base', 'video_ymse_data');
qual_all=q{1,video_index};
qual_qp(1,:)=rate_all(qp,tile,:);
qual_tile(:,:)=rate_all(:,tile,:);
end

