function gpuM2 = g(gpuM2,gpuM,cycles,N)
%G ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
for j = 1:cycles
for i = 1:N
    gpuM2(:,:,i) = gpuM(:,:,i)*gpuM(:,:,i);
end
end

end

