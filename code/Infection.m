function [ Susceptible_sequence,Latent_sequence,Infector_sequence,Dead_sequence,Cure_sequence,state ] = Infection( N,location,Susceptible_sequence,Latent_sequence,Infector_sequence,Dead_sequence,Cure_sequence,Infection_probability,Cure_probability,Death_probability,Infectious_radius,distance,incubation_period,state )
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[Ms,Ns]=size(Susceptible_sequence);
[Ml,Nl]=size(Latent_sequence);
[Mi,Ni]=size(Infector_sequence);
[Md,Nd]=size(Dead_sequence);
[Mc,Nc]=size(Cure_sequence);

% Ǳ���ߵ�״̬�ı�
[Xl,Yl]=find(state>1);
state(1,Yl)=state(1,Yl)-1;

%% ��Ⱦ
[Xi,Yi]=find(distance<Infectious_radius);%�ҵ����ܻᱻ��Ⱦ����
Xi=Xi';
Yi=Yi';
k=rand(1,length(Yi));
[m,n]=sort(k);
waiting_for_Infector=[];
waiting_for_Infector=find(k<Infection_probability);%���ݴ�Ⱦ���ʴ��г�ȡ��Χ�ڵ��˱���Ⱦ
Yi=Yi(waiting_for_Infector);
%��Ⱦ��Ǳ�����ߴ�Ⱦ�׸���Ⱥ����ת��ΪǱ����,�����ߡ�Ǳ�����Լ������߲����ٱ���Ⱦ
for i=1:1:length(Yi)
    if(state(1,Yi(i))==0||state(1,Yi(i))==-1)%������Ҳ�п����ٴθ�Ⱦ
%     if(state(1,Yi(i))==0)%�����߲����ٴθ�Ⱦ
        state(1,Yi(i))=1+incubation_period;
    end 
end

%% ����
[Xi,Yi]=find(state==1);%���µ�ǰ�ĸ�Ⱦ����Ŀ
k=rand(1,length(Yi));
[m,n]=sort(k);
dead_for_Infector=[];
dead_for_Infector=find(k<Death_probability);%���ݴ�Ⱦ���ʴ��г�ȡ��Χ�ڵ��˱���Ⱦ
Yi=Yi(dead_for_Infector);
for i=1:1:length(Yi)
    if(state(1,Yi(i))==1)
        state(1,Yi(i))=-99;
    end 
end

%% �������ȳŹ��������п��ܱ�����
[Xi,Yi]=find(state==1);%���µ�ǰ�ĸ�Ⱦ����Ŀ
k=rand(1,length(Yi));
[m,n]=sort(k);
cure_for_Infector=[];
cure_for_Infector=find(k<Cure_probability);%���ݴ�Ⱦ���ʴ��г�ȡ��Χ�ڵ��˱���Ⱦ
Yi=Yi(cure_for_Infector);
for i=1:1:length(Yi)
    if(state(1,Yi(i))==1)
        state(1,Yi(i))=-1;
    end 
end

Susceptible_sequence=find(state==0);
Infector_sequence=find(state==1);
Latent_sequence=find(state>1);
Dead_sequence=find(state==-99);
Cure_sequence=find(state==-1);


end

