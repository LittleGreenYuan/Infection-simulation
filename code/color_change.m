function [ state_color ] = color_change( state )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
state_color=zeros(3,length(state));

for i=1:1:length(state)
    if(state(i)==0)
        state_color(:,i)=[0;0;1];
    end
    if(state(i)==1)
        state_color(:,i)=[1;0;0];
    end
    if(state(i)>1)
        state_color(:,i)=[1;1;0];
    end
    if(state(i)==-1)
        state_color(:,i)=[0;0;1];
    end
    if(state(i)==-99)
        state_color(:,i)=[1;1;1];
    end
end
% state_color(:,find(state==0))=[0;0;1]; 
% state_color(:,find(state==1))=[1;0;0]; 
% state_color(:,find(state==6))=[1;1;0]; 
% state_color(:,find(state==-1))=[0;1;0]; 
% state_color(:,find(state==-99))=[0;0;0]; 


end

