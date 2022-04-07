clc;
clear;
% userpath('..\传染病模型\传播模拟\子函数1');
%% 参数初始化
global R0 %R0数值，代表一个人会传染给几个人
R0=50; %传染人数
global N %人口规模
N=2000;
global Susceptible %易感者数目
Susceptible=N;
global Latent %潜伏者数目(这里是自然发病概率*总人数)
Latent=round(0.99*N);
global Infected %感染者数目（初始为0）
Infected=50;
global Infection_probability %传染率
Infection_probability=R0*0.01;%每100个人有R0个人被传染
global Cure_probability %治愈率
Cure_probability=0.1;%每100个感染者中有1人被治愈
global Death_probability %死亡率
Death_probability=0.0014;%感染者的死亡率接近1.14%
global Sports_trend %运动趋势，有多少占比的人会执行运动
Sports_trend=round(0.99.*N);%99%的人都会执行运动操作
global Infectious_radius %传染半径，用来判断会传染给谁
Infectious_radius=20;%具体数值有待后续验证
global incubation_period %潜伏期，移动多少次后将潜伏者转变成感染者
incubation_period=5;%平均潜伏期

%易感者序列，用来存放易感者的序号
Susceptible_sequence=[];
%潜伏者序列，用来存放潜伏者的序号
Latent_sequence=[];
 %感染者序列，用来存放感染者的序号
Infector_sequence=[];
%死亡者序列，用来存放死亡者的序号
Dead_sequence=[];
%治愈者序列，用来存放治愈者的序号
Cure_sequence=[];
%用来记录各个类型的总人数
Mer_sequence=[];

location=normrnd(0,600,2,N);%产生2*300正态分布的随机数，第一行作为X，第二行作为Y
% %绘制坐标系
% figure();
% scatter(location(1,:),location(2,:),150,'.')
% %scatter(x,y,sz,c) 指定圆颜色。要以相同的颜色绘制所有圆圈，请将 c 指定为颜色名称或 RGB 三元数。要使用不同的颜色，请将 c 指定为向量或由 RGB 三元数组成的三列矩阵。
% set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')
% 
%将总人数进行随机排序，从中挑选被感染的人的位置
k=rand(1,N);
[m,n]=sort(k);%n代表最终总随机排序结果
Infector_sequence=n(1,1:Infected);
Susceptible_sequence=n(1,Infected+1:end);
state=zeros(1,N);%构建坐标点的状态矩阵，0表示易感者，1表示感染者，6表示潜伏者(减去潜伏期变成1)，-1表示治愈者,-99表示死亡者
state(1,Infector_sequence)=1;
state(1,Susceptible_sequence)=0;
figure()
[ state_color ] = color_change( state );
scatter(location(1,:),location(2,:),200,state_color' ,'.');
set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')
% saveas(gca,'0','jpg');
for j=1:1:2000
%移动距离生成与坐标更新
[ new_location ] = Moving( N,location,Sports_trend,Infector_sequence,Dead_sequence );
location=new_location;
%距离计算
[ distance,Ni,Nl ] = Distance_calculation( location,Infector_sequence,Latent_sequence,Dead_sequence );%计算感染者与其他易感者的距离
%刷新感染
[ Susceptible_sequence,Latent_sequence,Infector_sequence,Dead_sequence,Cure_sequence,state ] = Infection( N,location,Susceptible_sequence,Latent_sequence,Infector_sequence,Dead_sequence,Cure_sequence,Infection_probability,Cure_probability,Death_probability,Infectious_radius,distance,incubation_period,state );
Mer_sequence(j,1)=length(Susceptible_sequence);
Mer_sequence(j,2)=length(Latent_sequence);
Mer_sequence(j,3)=length(Infector_sequence);
Mer_sequence(j,4)=length(Dead_sequence);
Mer_sequence(j,5)=length(Cure_sequence);

[ state_color ] = color_change( state );


% figure();
% scatter(location(1,:),location(2,:),200,state_color','.');
% set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')
% saveas(gca,num2str(j),'jpg');
end
figure();
plot(Mer_sequence(:,1),'b')
hold on
plot(Mer_sequence(:,2),'y')
plot(Mer_sequence(:,3),'r')
plot(Mer_sequence(:,4),'k')
plot(Mer_sequence(:,5),'g')
