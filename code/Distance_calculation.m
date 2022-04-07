function [ distance,Ni,Nl ] = Distance_calculation( location,Infector_sequence,Latent_sequence,Dead_sequence )
%�����Ⱦ���������׸��ߵľ���
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Ni=length(Infector_sequence);
Nl=length(Latent_sequence);
distance_I=[];
if (Ni>0)
for i=1:1:Ni
    x=location(1,Infector_sequence(i));
    y=location(2,Infector_sequence(i));
    distance_I(i,:)=sqrt((location(1,:)-x).^2+(location(2,:)-y).^2);
end
distance_I(:,Latent_sequence)=98;
distance_I(:,Infector_sequence)=99;
distance_I(:,Dead_sequence)=100;
end
distance_L=[];
if (Nl>0)
for i=1:1:Nl
    x=location(1,Latent_sequence(i));
    y=location(2,Latent_sequence(i));
    distance_L(i,:)=sqrt((location(1,:)-x).^2+(location(2,:)-y).^2);
end
distance_L(:,Latent_sequence)=98;
distance_L(:,Infector_sequence)=99;
distance_L(:,Dead_sequence)=100;
end
distance=[distance_I;distance_L;];

end

