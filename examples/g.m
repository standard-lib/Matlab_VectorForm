function gpuM2 = g(gpuM2,gpuM,cycles,N)
%G この関数の概要をここに記述
%   詳細説明をここに記述
for j = 1:cycles
for i = 1:N
    gpuM2(:,:,i) = gpuM(:,:,i)*gpuM(:,:,i);
end
end

end

