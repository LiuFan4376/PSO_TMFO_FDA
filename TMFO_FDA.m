%% TDFO-FDA
clc;clear ;close;


%% ------TDFO-FDA雷达参数设置
j=sqrt(-1);
M=18; %发射阵元数目
f0=2e9; %载波中心频率
delta_f=3000; %相邻阵元频率偏移
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
g=(0:M-1);




%% -----TMFO-FDA波束方向图
P1 = zeros(length(theta),length(R)); %波束方向图
delta_f = TMFO(f0,d,c,theta0,R0,0);
Delta_f = (0:M-1)*delta_f;
 for n = 1 : length(theta)
    for m = 1 : length(R)
         a1=tmfo_AF(g,theta0,R0,theta(n),R(m),0); %导向矢量
         w1=ones(1,M);
          P1(n,m) =dot(a1,w1);
    end
 end
 
%% 画图
P1=P1';
figure(1); 
imagesc(theta*180/pi,R,abs(P1)/max(max(abs(P1)))); 
xlabel('\theta^o'); ylabel('R/m'); 
axis tight; axis xy;
title('');
colorbar;






%% -----FDA时间角度维波束方向图
T=linspace(0,0.2e-3,500);
P2 = zeros(length(theta),length(T)); %波束方向图
 for n = 1 : length(theta)
    for m = 1 : length(T)
         a2=tmfo_AF(g,theta0,R0,theta(n),R0,T(m)); 
%          w2=correct_tmfo_af(g,theta0,R0,theta0,R0,T(1));
        P2(n,m) =dot(a2,w1);
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



%% --------------FDA时间距离维波束方向图     
P3 = zeros(length(R),length(T)); %波束方向图
 for n = 1 : length(R)
    for m = 1 : length(T)
       a3=tmfo_AF(g,theta0,R0,theta0,R(n),T(m)); 
%        w3=correct_tmfo_af(g,theta0,R0,theta0,R0,T(1));
        P3(n,m) =dot(a3,w1);
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