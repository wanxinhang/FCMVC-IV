function [Z] = initialize_Z(X,num_cluster)
%INITIALIZE_Z �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
num_dimension=size(X,1);
H=zeros(num_dimension,num_cluster);
if size(X,1)>=num_cluster
    for i=1:num_cluster
        H(i,i)=1;
    end
else
    for i=1:size(X,1)
        H(i,i)=1;
    end
end
[U,~,V] = svd(X'*H,'econ');
Z=U*V';
Z=Z';
end

