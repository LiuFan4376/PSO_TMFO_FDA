%% TDFO-FDA
clc;clear ;close;


%% ------TDFO-FDA�״��������
j=sqrt(-1);
M=18; %������Ԫ��Ŀ
f0=2e9; %�ز�����Ƶ��
delta_f=3000; %������ԪƵ��ƫ��
c=3e8;        %����
lamda=c/f0;  %����
d=lamda/2;    %��Ԫ���
D=d*(0:M-1);
Ru=c/delta_f;  %�����ģ������
theta=(-90:1:90)*pi/180; %�����Ƕ�����
R=linspace(0,3e5,1000); %������������
f=f0+(0:M-1)*delta_f; %��Ԫ��Ƶ�����������������ӣ�
R0 = 1e5; %����ָ��Ŀ��ľ���
theta0 = 30/180*pi;  %%����ָ��Ŀ��ĽǶ�
g=(0:M-1);




%% -----TMFO-FDA��������ͼ
P1 = zeros(length(theta),length(R)); %��������ͼ
delta_f = TMFO(f0,d,c,theta0,R0,0);
Delta_f = (0:M-1)*delta_f;
 for n = 1 : length(theta)
    for m = 1 : length(R)
         a1=tmfo_AF(g,theta0,R0,theta(n),R(m),0); %����ʸ��
         w1=ones(1,M);
          P1(n,m) =dot(a1,w1);
    end
 end
 
%% ��ͼ
P1=P1';
figure(1); 
imagesc(theta*180/pi,R,abs(P1)/max(max(abs(P1)))); 
xlabel('\theta^o'); ylabel('R/m'); 
axis tight; axis xy;
title('');
colorbar;






%% -----FDAʱ��Ƕ�ά��������ͼ
T=linspace(0,0.2e-3,500);
P2 = zeros(length(theta),length(T)); %��������ͼ
 for n = 1 : length(theta)
    for m = 1 : length(T)
         a2=tmfo_AF(g,theta0,R0,theta(n),R0,T(m)); 
%          w2=correct_tmfo_af(g,theta0,R0,theta0,R0,T(1));
        P2(n,m) =dot(a2,w1);
    end
 end
%% ��ͼ��ʱ��Ƕ�ά
% P2=P2';
figure(2); 
imagesc(T,theta*180/pi,abs(P2)/max(max(abs(P2)))); 
ylabel('\theta^o'); xlabel('ʱ��/ms'); 
axis tight; axis xy;
title('');
colorbar;



%% --------------FDAʱ�����ά��������ͼ     
P3 = zeros(length(R),length(T)); %��������ͼ
 for n = 1 : length(R)
    for m = 1 : length(T)
       a3=tmfo_AF(g,theta0,R0,theta0,R(n),T(m)); 
%        w3=correct_tmfo_af(g,theta0,R0,theta0,R0,T(1));
        P3(n,m) =dot(a3,w1);
    end
 end
%% ��ͼ��ʱ�����ά��������ͼ
% P3=P3';
figure(3); 
imagesc(T,R,abs(P3)/max(max(abs(P3)))); 
ylabel('R/m'); xlabel('ʱ��/ms'); 
axis tight; axis xy;
title('');
colorbar;