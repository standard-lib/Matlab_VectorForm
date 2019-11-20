clear all
addpath('..');
N = 1000; %number of 4x4 matries
cycles = 10;

%%% integer
for i = 1:N
    m(:,:,i) = randi(2^16, 4, 4); %allocate in different pages
    v(:,i) = VectorForm.ToVectorForm( m(:,:, i));
end

tic
for j = 1:cycles
for i = 1:N
    m2(:,:,i) = m(:,:,i)*m(:,:,i);
end
end
toc

tic
for j = 1:cycles
v2 = VectorForm.Mul4(v, v);
end
toc
%%

gpuM = gpuArray(m);
gpuM2 = gpuArray(m2);
f=@() g(m2,m,cycles,N);
gputimeit(f)

%%

m2(:,:,1);
v2(:,1);

gpuV = gpuArray(v);
gpuV2 = gpuArray(v);
tic
for gpuj = 1:cycles
gpuV2 = VectorForm.Mul4(gpuV, gpuV);
end
toc


m2(:,:,1);
v2(:,1);