function[ new_location ] = Moving( N,location,Sports_trend,Infector_sequence,Dead_sequence )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
location_add=10*normrnd(0,1,2,N);%����2*300��̬�ֲ������������һ����ΪX���ڶ�����ΪY
k=rand(1,N);
[m,n]=sort(k);%n�������������������
%��Ⱦ���ƶ������ܵ�������
location_add(:,Infector_sequence)=0.5*location_add(:,Infector_sequence);
%���������ǲ����ƶ���
location_add(:,Dead_sequence)=0;
%�����ƶ������ƶ�����Ϊ0
location_add(:,n(Sports_trend+1:end))=0;

new_location=location_add+location;
end

