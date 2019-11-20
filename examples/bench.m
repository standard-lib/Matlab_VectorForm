clear all
addpath('..');
cycles = 1;
obj = VectorForm();
Ns = floor(10.^([5:0.5:5])); 
avg_time_loop = zeros( numel(Ns),1);
avg_time_vctrz = zeros( numel(Ns),1);
avg_time_gpuloop = zeros( numel(Ns),1);
avg_time_gpuvctrz = zeros( numel(Ns),1);

cnt = 1;
for N = Ns
    fprintf('calculating N = %d...\n', N);
    %%% integer
    for i = 1:N
        m(:,:,i) = randi(2^16, 4, 4); %allocate in different pages
        v(:,i) = VectorForm.ToVectorForm( m(:,:, i));
    end
    tic
    gpuM = gpuArray(m);
    gpuV = gpuArray(v);
    disp('Elapsed time in sending data to GPU:');
    toc
    
    time_arr = zeros(cycles,1);
    if( N > 10^4 )
        avg_time_loop(cnt) = NaN;
    else
        f = @() inv_loop(m,N);
        for j = 1:cycles
            time_arr(j) = timeit(f);
        end
        avg_time_loop(cnt) = mean(time_arr);
    end
    
    f = @() obj.Inv4(v);
    for j = 1:cycles
        time_arr(j) = timeit(f);
    end
    avg_time_vctrz(cnt) = mean(time_arr);
    
    % loop method on gpu skip if N > 10^3
    if( N > 10^2 ) 
        avg_time_gpuloop(cnt) = NaN;
    else
        f = @() inv_loop(gpuM,N);
        for j = 1:cycles
            time_arr(j) = gputimeit(f);
        end
        avg_time_gpuloop(cnt) = mean(time_arr);
    end
    
    % vectorized method on gpu
    f = @() obj.Inv4(gpuV);
    for j = 1:cycles
        time_arr(j) = gputimeit(f);
    end
    avg_time_gpuvctrz(cnt) = mean(time_arr);

    cnt = cnt+1;
end
%%
figure(1)
subplot(121);
loglog(Ns, avg_time_loop, '-s', Ns, avg_time_vctrz, '-s'); hold on;
set(gca, 'ColorOrderIndex',1);
loglog(Ns, avg_time_gpuloop, '--s', Ns, avg_time_gpuvctrz, '--s');
hold off;
ylabel('Elapsed time [s]');
xlabel('Number of Matrices');
legend('Loop-calculation on host', 'Vectorized-calculation on host',...
    'Loop-calculation on GPU', 'Vectorized-calculation on GPU', 'location', 'southeast');


subplot(122);
loglog(Ns, Ns'./avg_time_loop, '-s',  Ns, Ns'./avg_time_vctrz, '-s'); hold on;
set(gca, 'ColorOrderIndex',1);
loglog(Ns, Ns'./avg_time_gpuloop, '--s',  Ns, Ns'./avg_time_gpuvctrz, '--s');
hold off
ylabel('Calculation speed [Matrices/s]');
clear m v gpuM gpuV

%save('4x4Inverse-integer.mat');

