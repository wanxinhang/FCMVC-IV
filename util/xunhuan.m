function [Z] = xunhuan(fea, num_cluster,S)
%XUNHUAN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
num_view = length(fea);
time=0;
num_sample = size(fea{1},2);
rest=cell(num_view,1);
the_rest=cell(num_view,1);
all=1:num_sample;
for p =1:num_view
    if p==1
        rest{p}=all(~ismember(all,S{p}));%������������δȱʧ������
        the_rest{p}=rest{p};
        X=fea{p}(:,the_rest{p});
        Z=initialize_Z(X,num_cluster);
%         size(Z);
%         error("��ͣ")
    else
        rest{p}=all(~ismember(all,S{p}));
        the_rest{p}=union(rest{p},the_rest{p-1});
        nv_t=size(the_rest{p},2);%һ���ж���ûȱʧ
        nv_t_=size(the_rest{p-1},2);%��һ���ж���ûȱʧ
        nv_s=size(rest{p},2);%��ǰ��ͼ�ж���û��ʧ
        tmp=zeros(num_sample,num_sample);
        for i=1:nv_s
            tmp(rest{p}(i),rest{p}(i))=1;
        end
        M1=tmp(the_rest{p},rest{p});
        tmp=zeros(num_sample,num_sample);
        for i=1:nv_t_
            tmp(the_rest{p-1}(i),the_rest{p-1}(i))=1;
        end     
        M2=tmp(the_rest{p},the_rest{p-1});
        X=fea{p}(:,rest{p});
        Z=each_iter(X,M1,M2,num_cluster,Z);
    end

end

end

