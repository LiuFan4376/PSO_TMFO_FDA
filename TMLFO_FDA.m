%% TMLFO-FDA
clc;clear ;close;


%% ------TMLFO-FDA雷达参数设置
j=sqrt(-1);
M=18; %发射阵元数目
f0=5e9; %载波中心频率
delta_f=2000; %相邻阵元频率偏移
c=3e8;        %光速
lamda=c/f0;  %波长
d=lamda/2;    %阵元间距
D=d*(0:M-1);
Ru=c/delta_f;  %最大无模糊距离
theta=(-90:1:90)*pi/180; %测量角度向量
R=linspace(0,3e5,1000); %测量距离向量
f=f0+(0:M-1)*delta_f; %阵元载频向量（均匀线性增加）
R0 = 1e5; %天线指向目标的距离
theta0 = 30/180*pi;  %%天线指向目标的角度
T=linspace(0,0.2e-3,500);% 一个Tp
g=log((1:M));

%% ----波束方向图 t=0ms
P1 = zeros(length(theta),length(R)); %波束方向图
 for n = 1 : length(theta)
    for m = 1 : length(R)
%          Delta_f=TMLFO(f0,d,c,M,theta0,R0,0.01e-3);
%          a1=exp(-j*2*pi/c*(Delta_f'*R(m)-f0*D'*sin(theta(n)))); %导向矢量
%          w=exp(-j*2*pi/c*(Delta_f'*R0-f0*D'*sin(theta0)));

         a1=tmfo_AF(g,theta0,R0,theta(n),R(m),T(1));
          w1=ones(M,1);
         P1(n,m) =dot(a1,w1);
    end
 end
 
P1=P1';
figure(1); 
imagesc(theta*180/pi,R,abs(P1)/max(max(abs(P1)))); 
xlabel('\theta^o'); ylabel('R/m'); 
axis tight; axis xy;
title('');
colorbar;


%% -----时间角度维波束方向图
P2 = zeros(length(theta),length(T)); %波束方向图
 for n = 1 : length(theta)
    for m = 1 : length(T)
%         Delta_f=TMLFO(f0,d,c,M,theta0,R0,T(m));
         a2=tmfo_AF(g,theta0,R0,theta(n),R0,T(m));
          w2=tmfo_AF(g,theta0,R0,theta0,R0,T(1));
%          a2=exp(-j*2*pi/c*(-Delta_f'*T(m)*c-D'*f0*sin(theta(n))+Delta_f'*R0)); %导向矢量
%          w2=exp(-j*2*pi/c*(-Delta_f'*T(1)*c-D'*f0*sin(theta0)+Delta_f'*R0)); 
        % w2=ones(12,1);
        P2(n,m) =w2'*a2;
    end
 end
%% 画图：时间角度维
% P2=P2';
figure(2); 
imagesc(T,theta*180/pi,abs(P2)/max(max(abs(P2)))); 
ylabel('\theta^o'); xlabel('时间/ms'); 
axis tight; axis xy;
title('');
colorbar;



%% --------------时间距离维波束方向图     
P3 = zeros(length(R),length(T)); %波束方向图
 for n = 1 : length(R)
    for m = 1 : length(T)
         a3=tmfo_AF(g,theta0,R0,theta0,R(n),T(m));
          w3=tmfo_AF(g,theta0,R0,theta0,R0,T(1));
%         Delta_f=TMLFO(f0,d,c,M,theta0,R0,T(m));
%          a3=exp(-j*2*pi/c*(-Delta_f'*T(m)*c+Delta_f'*R(n)-D'*f0*sin(theta0))); %导向矢量
%          w3=exp(-j*2*pi/c*(-Delta_f'*T(1)*c+Delta_f'*R0-D'*f0*sin(theta0))); 
        P3(n,m) =w3'*a3;
    end
 end
%% 画图：时间距离维波束方向图
% P3=P3';
figure(3); 
imagesc(T,R,abs(P3)/max(max(abs(P3)))); 
ylabel('R/m'); xlabel('时间/ms'); 
axis tight; axis xy;
title('');
colorbar;

