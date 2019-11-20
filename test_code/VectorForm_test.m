addpath('..');
v = [1:8 9 10 11 10 13 14 17 1];
v = v';
m = [1:4;5:8; 9 10 11 10;13 14 17 1];
%stifMatrx_Knp_focus.vect_mul4(v,v)
%m*m
obj = VectorForm();

tinvm = transpose(inv(m));
invv = obj.Inv4(v);

for i=1:16
    assert( tinvm(i)-invv(i) < 0.001 );
end

%stifMatrx_Knp_focus.vect_cofact(v, stifMatrx_Knp_focus.getSmallMatIdx(1,1))
%stifMatrx_Knp_focus.vect_cofact(v, stifMatrx_Knp_focus.getSmallMatIdx(1,2))
