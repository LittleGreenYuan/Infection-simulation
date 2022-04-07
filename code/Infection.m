function [ Susceptible_sequence,Latent_sequence,Infector_sequence,Dead_sequence,Cure_sequence,state ] = Infection( N,location,Susceptible_sequence,Latent_sequence,Infector_sequence,Dead_sequence,Cure_sequence,Infection_probability,Cure_probability,Death_probability,Infectious_radius,distance,incubation_period,state )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
[Ms,Ns]=size(Susceptible_sequence);
[Ml,Nl]=size(Latent_sequence);
[Mi,Ni]=size(Infector_sequence);
[Md,Nd]=size(Dead_sequence);
[Mc,Nc]=size(Cure_sequence);

% 潜伏者的状态改变
[Xl,Yl]=find(state>1);
state(1,Yl)=state(1,Yl)-1;

%% 传染
[Xi,Yi]=find(distance<Infectious_radius);%找到可能会被感染的人
Xi=Xi';
Yi=Yi';
k=rand(1,length(Yi));
[m,n]=sort(k);
waiting_for_Infector=[];
waiting_for_Infector=find(k<Infection_probability);%根据传染概率从中抽取范围内的人被感染
Yi=Yi(waiting_for_Infector);
%感染与潜伏者者传染易感人群将其转变为潜伏者,治愈者、潜伏者以及死亡者不会再被传染
for i=1:1:length(Yi)
    if(state(1,Yi(i))==0||state(1,Yi(i))==-1)%康复者也有可能再次感染
%     if(state(1,Yi(i))==0)%康复者不会再次感染
        state(1,Yi(i))=1+incubation_period;
    end 
end

%% 死亡
[Xi,Yi]=find(state==1);%更新当前的感染者数目
k=rand(1,length(Yi));
[m,n]=sort(k);
dead_for_Infector=[];
dead_for_Infector=find(k<Death_probability);%根据传染概率从中抽取范围内的人被感染
Yi=Yi(dead_for_Infector);
for i=1:1:length(Yi)
    if(state(1,Yi(i))==1)
        state(1,Yi(i))=-99;
    end 
end

%% 治愈，先撑过死亡才有可能被治愈
[Xi,Yi]=find(state==1);%更新当前的感染者数目
k=rand(1,length(Yi));
[m,n]=sort(k);
cure_for_Infector=[];
cure_for_Infector=find(k<Cure_probability);%根据传染概率从中抽取范围内的人被感染
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

