function [m2] = mul_loop(m,N)
%UNTITLED2 ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
    for i = 1:N
        m2(:,:,i) = inv(m(:,:,i));
    end
end

