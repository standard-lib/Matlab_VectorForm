classdef VectorForm
    %VectorForm Library for performing matrix operations on one or more matrices expressed in Vector format
    % vector形式は，NxN行列をN^2成分の列ベクトルと変換したもの．
    % 例えば2x2行列をVector形式にすると，上から(1,1), (2,1), (1,2), (2,2)成分が並ぶ．
    % なお，Matlabは列メジャーであるため，M(2,2) をM(:)とすれば，自然にvector形式になる．
    properties
        f_inv4;
    end
    methods
        function obj = VectorForm()
            M = 4;
            As = sym('a', [M,M]); % Define an MxM matrix as a symbolic variable
            invAs = reshape(inv(As),[],1); % Solve inverse matrix in symbol
            obj.f_inv4 = matlabFunction(invAs,'Vars',As); % Convert the symbolic function to an anonymous function.
        end
        function vectOut = Inv4(obj, vectIn )
            vectOut = obj.f_inv4( ...
                 vectIn(1,:)...
               , vectIn(2,:)...
               , vectIn(3,:)...
               , vectIn(4,:)...
               , vectIn(5,:)...
               , vectIn(6,:)...
               , vectIn(7,:)...
               , vectIn(8,:)...
               , vectIn(9,:)...
               , vectIn(10,:)...
               , vectIn(11,:)...
               , vectIn(12,:)...
               , vectIn(13,:)...
               , vectIn(14,:)...
               , vectIn(15,:)...
               , vectIn(16,:));
        end
    end
    methods(Static)
        function vectOut = ToVectorForm( matrix )
            vectOut = matrix(:);
        end
        function matrix = ToMatrixForm( vectIn, dimension )
            matrix = reshape( vectIn, dimension, dimension );
        end
        %{
		function vectsOut = Mul2(vectsIn1, vectsIn2)
            vectsOut = zeros(size(vectsIn1));
            vectsOut(1,:) = vectsIn1(1,:).*vectsIn2(1,:) + vectsIn1(3,:).*vectsIn2(2,:);
            vectsOut(2,:) = vectsIn1(2,:).*vectsIn2(1,:) + vectsIn1(4,:).*vectsIn2(2,:);
            vectsOut(3,:) = vectsIn1(1,:).*vectsIn2(3,:) + vectsIn1(3,:).*vectsIn2(4,:);
            vectsOut(4,:) = vectsIn1(2,:).*vectsIn2(3,:) + vectsIn1(4,:).*vectsIn2(4,:);
        end
		function vectsOut = Mul4(vs1, vs2)
            vectsOut( 1,:) = vs1(1,:).*vs2( 1,:) + vs1(5,:).*vs2( 2,:) + vs1( 9,:).*vs2( 3,:) + vs1(13,:).*vs2( 4,:);
            vectsOut( 2,:) = vs1(2,:).*vs2( 1,:) + vs1(6,:).*vs2( 2,:) + vs1(10,:).*vs2( 3,:) + vs1(14,:).*vs2( 4,:);
            vectsOut( 3,:) = vs1(3,:).*vs2( 1,:) + vs1(7,:).*vs2( 2,:) + vs1(11,:).*vs2( 3,:) + vs1(15,:).*vs2( 4,:);
            vectsOut( 4,:) = vs1(4,:).*vs2( 1,:) + vs1(8,:).*vs2( 2,:) + vs1(12,:).*vs2( 3,:) + vs1(16,:).*vs2( 4,:);
            vectsOut( 5,:) = vs1(1,:).*vs2( 5,:) + vs1(5,:).*vs2( 6,:) + vs1( 9,:).*vs2( 7,:) + vs1(13,:).*vs2( 8,:);
            vectsOut( 6,:) = vs1(2,:).*vs2( 5,:) + vs1(6,:).*vs2( 6,:) + vs1(10,:).*vs2( 7,:) + vs1(14,:).*vs2( 8,:);
            vectsOut( 7,:) = vs1(3,:).*vs2( 5,:) + vs1(7,:).*vs2( 6,:) + vs1(11,:).*vs2( 7,:) + vs1(15,:).*vs2( 8,:);
            vectsOut( 8,:) = vs1(4,:).*vs2( 5,:) + vs1(8,:).*vs2( 6,:) + vs1(12,:).*vs2( 7,:) + vs1(16,:).*vs2( 8,:);
            vectsOut( 9,:) = vs1(1,:).*vs2( 9,:) + vs1(5,:).*vs2(10,:) + vs1( 9,:).*vs2(11,:) + vs1(13,:).*vs2(12,:);
            vectsOut(10,:) = vs1(2,:).*vs2( 9,:) + vs1(6,:).*vs2(10,:) + vs1(10,:).*vs2(11,:) + vs1(14,:).*vs2(12,:);
            vectsOut(11,:) = vs1(3,:).*vs2( 9,:) + vs1(7,:).*vs2(10,:) + vs1(11,:).*vs2(11,:) + vs1(15,:).*vs2(12,:);
            vectsOut(12,:) = vs1(4,:).*vs2( 9,:) + vs1(8,:).*vs2(10,:) + vs1(12,:).*vs2(11,:) + vs1(16,:).*vs2(12,:);
            vectsOut(13,:) = vs1(1,:).*vs2(13,:) + vs1(5,:).*vs2(14,:) + vs1( 9,:).*vs2(15,:) + vs1(13,:).*vs2(16,:);
            vectsOut(14,:) = vs1(2,:).*vs2(13,:) + vs1(6,:).*vs2(14,:) + vs1(10,:).*vs2(15,:) + vs1(14,:).*vs2(16,:);
            vectsOut(15,:) = vs1(3,:).*vs2(13,:) + vs1(7,:).*vs2(14,:) + vs1(11,:).*vs2(15,:) + vs1(15,:).*vs2(16,:);
            vectsOut(16,:) = vs1(4,:).*vs2(13,:) + vs1(8,:).*vs2(14,:) + vs1(12,:).*vs2(15,:) + vs1(16,:).*vs2(16,:);
        end
		function vectOut = Four2x2(vectIn)
            vectOut = vectIn;
            vectOut(:,3)  = vectIn(:,5);
            vectOut(:,4)  = vectIn(:,6);
            vectOut(:,5)  = vectIn(:,3);
            vectOut(:,6)  = vectIn(:,4);
            vectOut(:,11) = vectIn(:,13);
            vectOut(:,12) = vectIn(:,14);
            vectOut(:,13) = vectIn(:,11);
            vectOut(:,14) = vectIn(:,12);
        end
        function vectOut = Inv4( vectIn )
            vectOut = zeros(size(vectIn));
            idx = 1;
            detsign = -1/VectorForm.Det4(vectIn);
            for i = 1:4
                for j =1:4
                    detsign = detsign * -1;
                     vectOut(:,idx) = detsign*VectorForm.Cofact4( vectIn, VectorForm.SmallMatIdx( j, i ));
                    idx = idx+1;
                end
                detsign = detsign * -1;
            end
            
        end
        function out = Det4( vectIn )
            out = vectIn(1)*VectorForm.Cofact4( vectIn, VectorForm.SmallMatIdx( 1, 1 )) ...
               -  vectIn(2)*VectorForm.Cofact4( vectIn, VectorForm.SmallMatIdx( 1, 2 ))...
               +  vectIn(3)*VectorForm.Cofact4( vectIn, VectorForm.SmallMatIdx( 1, 3 ))...
               -  vectIn(4)*VectorForm.Cofact4( vectIn, VectorForm.SmallMatIdx( 1, 4 ));
        end
        function small_mat_idx = SmallMatIdx( i, j )
            small_mat_idx = zeros(9,1);
            outIdx = 1;
            for checkIdx = 1:16
                if( j-1 ~= mod( checkIdx-1, 4  ) && i-1 ~= floor( (checkIdx-1)/4 ) )
                    small_mat_idx( outIdx ) = checkIdx;
                    outIdx = outIdx + 1;
                end
            end
        end
        function cofact = Cofact4( vectIn, sidx )
            %idxPlus = [ 1 5 9; 2 6 7; 3 4 8 ];
            %idxMinus = [ 1 6 8; 2 4 9; 3 5 7 ];
            cofact = vectIn(sidx(1))*vectIn(sidx(5))*vectIn(sidx(9)) ...
                   + vectIn(sidx(2))*vectIn(sidx(6))*vectIn(sidx(7)) ...
                   + vectIn(sidx(3))*vectIn(sidx(4))*vectIn(sidx(8)) ...
                  -( vectIn(sidx(1))*vectIn(sidx(6))*vectIn(sidx(8)) ...
                   + vectIn(sidx(2))*vectIn(sidx(4))*vectIn(sidx(9)) ...
                   + vectIn(sidx(3))*vectIn(sidx(5))*vectIn(sidx(7)));
        end
    %}
    end
        
end
