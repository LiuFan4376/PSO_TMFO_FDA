function a = non_liner_a(g,R,theta)
%NL_F ������Ƶƫ����ʸ���������
%   gΪ������Ƶƫ�ķ����Ժ�����R Ϊ���룻theta Ϊ�Ƕ�
c=3e8;
f0=2e9; %�ز�����Ƶ��
j=sqrt(-1);
lamda=c/f0;  %����
d=lamda/2;    %��Ԫ���
[N,M]=size(g);
delta_f=3000; %Ƶ��ƫ��



if N==1
D=d*(0:M-1);  %���о�������
Delta_f=g*delta_f;
a=exp(-j*2*pi/c*(Delta_f'*R-D'*f0*sin(theta)));
else
    D=ones(N,M);
   for i=1:N
    D(i,:)=(0:M-1)*d;
   end
   Delta_f=g*delta_f;
   a=exp(-j*2*pi/c*(Delta_f'*R-D'*f0*sin(theta)));;
end

end

