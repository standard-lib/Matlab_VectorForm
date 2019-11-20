function [m2] = mul_loop(m,N)
%UNTITLED2 この関数の概要をここに記述
%   詳細説明をここに記述
    for i = 1:N
        m2(:,:,i) = inv(m(:,:,i));
    end
end

