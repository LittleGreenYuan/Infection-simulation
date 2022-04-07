clc;
clear;
% userpath('..\��Ⱦ��ģ��\����ģ��\�Ӻ���1');
%% ������ʼ��
global R0 %R0��ֵ������һ���˻ᴫȾ��������
R0=50; %��Ⱦ����
global N %�˿ڹ�ģ
N=2000;
global Susceptible %�׸�����Ŀ
Susceptible=N;
global Latent %Ǳ������Ŀ(��������Ȼ��������*������)
Latent=round(0.99*N);
global Infected %��Ⱦ����Ŀ����ʼΪ0��
Infected=50;
global Infection_probability %��Ⱦ��
Infection_probability=R0*0.01;%ÿ100������R0���˱���Ⱦ
global Cure_probability %������
Cure_probability=0.1;%ÿ100����Ⱦ������1�˱�����
global Death_probability %������
Death_probability=0.0014;%��Ⱦ�ߵ������ʽӽ�1.14%
global Sports_trend %�˶����ƣ��ж���ռ�ȵ��˻�ִ���˶�
Sports_trend=round(0.99.*N);%99%���˶���ִ���˶�����
global Infectious_radius %��Ⱦ�뾶�������жϻᴫȾ��˭
Infectious_radius=20;%������ֵ�д�������֤
global incubation_period %Ǳ���ڣ��ƶ����ٴκ�Ǳ����ת��ɸ�Ⱦ��
incubation_period=5;%ƽ��Ǳ����

%�׸������У���������׸��ߵ����
Susceptible_sequence=[];
%Ǳ�������У��������Ǳ���ߵ����
Latent_sequence=[];
 %��Ⱦ�����У�������Ÿ�Ⱦ�ߵ����
Infector_sequence=[];
%���������У�������������ߵ����
Dead_sequence=[];
%���������У�������������ߵ����
Cure_sequence=[];
%������¼�������͵�������
Mer_sequence=[];

location=normrnd(0,600,2,N);%����2*300��̬�ֲ������������һ����ΪX���ڶ�����ΪY
% %��������ϵ
% figure();
% scatter(location(1,:),location(2,:),150,'.')
% %scatter(x,y,sz,c) ָ��Բ��ɫ��Ҫ����ͬ����ɫ��������ԲȦ���뽫 c ָ��Ϊ��ɫ���ƻ� RGB ��Ԫ����Ҫʹ�ò�ͬ����ɫ���뽫 c ָ��Ϊ�������� RGB ��Ԫ����ɵ����о���
% set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')
% 
%������������������򣬴�����ѡ����Ⱦ���˵�λ��
k=rand(1,N);
[m,n]=sort(k);%n�������������������
Infector_sequence=n(1,1:Infected);
Susceptible_sequence=n(1,Infected+1:end);
state=zeros(1,N);%����������״̬����0��ʾ�׸��ߣ�1��ʾ��Ⱦ�ߣ�6��ʾǱ����(��ȥǱ���ڱ��1)��-1��ʾ������,-99��ʾ������
state(1,Infector_sequence)=1;
state(1,Susceptible_sequence)=0;
figure()
[ state_color ] = color_change( state );
scatter(location(1,:),location(2,:),200,state_color' ,'.');
set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')
% saveas(gca,'0','jpg');
for j=1:1:2000
%�ƶ������������������
[ new_location ] = Moving( N,location,Sports_trend,Infector_sequence,Dead_sequence );
location=new_location;
%�������
[ distance,Ni,Nl ] = Distance_calculation( location,Infector_sequence,Latent_sequence,Dead_sequence );%�����Ⱦ���������׸��ߵľ���
%ˢ�¸�Ⱦ
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
