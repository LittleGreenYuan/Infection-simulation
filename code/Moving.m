function[ new_location ] = Moving( N,location,Sports_trend,Infector_sequence,Dead_sequence )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
location_add=10*normrnd(0,1,2,N);%产生2*300正态分布的随机数，第一行作为X，第二行作为Y
k=rand(1,N);
[m,n]=sort(k);%n代表最终总随机排序结果
%感染者移动距离受到了限制
location_add(:,Infector_sequence)=0.5*location_add(:,Infector_sequence);
%死亡患者是不会移动的
location_add(:,Dead_sequence)=0;
%不想移动的人移动距离为0
location_add(:,n(Sports_trend+1:end))=0;

new_location=location_add+location;
end

