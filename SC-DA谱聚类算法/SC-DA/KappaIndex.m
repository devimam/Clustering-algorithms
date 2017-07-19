function  [Kappaindex]=KappaIndex(A,IDX,patternNum,k)
%��¼ԭʼ����ͬһ���������λ��
OL=cell(k,1);
for i=1:k
    OL{i,1}=find(A(end,:)==i);
end
%ͳ��ԭʼ����ͬһ������������ڱ�������
SLabel=cell(k,1);
for i=1:k
    number_class(i)=max(size(OL{i,1}));
    for j=1:number_class(i)
        temp=OL{i,1}(j);
        SLabel{i,1}(j)=IDX(temp);
    end
end
CL=zeros(k,k);%ͳ��ԭʼ�����ÿ���еķֲ������������ÿ�е�������ԭʼ����
for i=1:k
    for j=1:k
        [m,n]=size(find(SLabel{i,1}==j));
        CL(i,j)=n;
    end
end
temp=0;
ON=zeros(1,k);%��¼ԭʼ������µ�����Ķ�Ӧ��ϵ
number_correct=zeros(1,k);%��¼ԭʼ�����е���ȷ�����������
while (temp<k)%ȷ���������������ż���ԭʼ���ŵĶ����ϵ���Լ�������ȷ������������
    temp=temp+1;
    maxval=max(CL(:));
    if maxval==0%����ĳ����û������,���ʣ�µĻ�δ�ҵ���Ӧ��ı����ѡ��
        class_unlabel=find(ON(:)==0);%�ҵ�δ��ǵ�����
        number_class_un=max(size(class_unlabel));%ͳ��δ��������ĸ���
        index_label_match=find(ON(:)~=0);        
        label_unmatch=1:1:k;%�ҵ�Ϊ����ƥ��ı��
        number_valid=0;
        for i=1:(k-number_class_un)
            value_label_match=ON(index_label_match(i));
            for j=1:k
                if label_unmatch(j)==value_label_match
                   label_unmatch(j)=0;
                else
                number_valid=number_valid+1;%���ñ�Ż�δƥ�䣬����Ϊ��Ч��ţ���洢��label_unmatch_valid�У���Ч��ŵĸ�������1
                label_unmatch_valid(number_valid)=label_unmatch(j);
                end
            end
        end
        for i=1:number_class_un
            ON(class_unlabel(i))=label_unmatch_valid(i);%��δ���������ӦΪ������������
        end
        temp=k;
    else
        [sm,sn]=find(CL==maxval);
        if max(size(sm))>1
            fsm=sm(1);
            fsn=sn(1);
        else
            fsm=sm;
            fsn=sn;
        end
        ON(1,fsm)=fsn;
        number_correct(1,fsm)=maxval;
        CL(fsm,:)=0;
        CL(:,fsn)=0;
    end
end
%��¼ԭʼ���ݺ;����ÿ���е������
index_original=A(end,:);%��ԭʼ��Ŵ������
index_new=IDX;%�Ѿ������ı�Ŵ���þ���
number_original=zeros(k,1);%��¼ԭʼ���ݼ�ÿ���������
number_new=zeros(k,1);%��¼��������ÿ���������
for i=1:k
    number_original(i)=length(find(index_original==i));
    number_new(i)=length(find(index_new==i));
end
sum_product_match=0;
for i=1:k
    sum_product_match=sum_product_match+number_original(i)*number_new(ON(i));
end
Ka_up_left=sum(number_correct)*patternNum;
Ka_up_right=sum_product_match;
Ka_down_left=patternNum*patternNum;
Ka_down_right=sum_product_match;
Kappaindex=(Ka_up_left-Ka_up_right)/(Ka_down_left-Ka_down_right);
