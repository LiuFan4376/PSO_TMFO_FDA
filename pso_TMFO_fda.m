clc,
clear;

%% ------雷达参数设置
j=sqrt(-1);
M=18; %发射阵元数目
f0=2e9; %载波中心频率
delta_f=2000; %相邻阵元频率偏移
c=3e8;        %光速
lamda=c/f0;  %波长
d=lamda/2;    %阵元间距
D=d*(0:M-1);
Ru=c/delta_f;  %最大无模糊距离
theta=(-90:1:90)*pi/180; %测量角度向量
R=linspace(0,3e5,1000); %测量距离向量
R0 = 1e5; %天线指向目标的距离
theta0 = 30/180*pi;  %%天线指向目标的角度
T=linspace(0,0.2e-3,500);% 一个Tp
%   g=pso_TMFO(M);
%   g=[ 62.7905   42.4537   39.0487   65.4355  -88.3337   83.7941  -83.4741   79.6446   66.6791   80.8937   56.9869   16.4964];
% g=[12.7292166123172	13.5478618251459	16	14.7284104015400	16	12.6885502338488	13.4861849593420	16	13.2784420761201	12.8652854124915	14.2314070415538	14.4750884198357	13.3153101734336	15.0783604704093	12.2798964020227	16];
g=[-0.957822477778220	-0.197380898911308	1.39282645843528	0.0668702147769616	1.90678491156174	2.96012586870465	1.01266243199329	3.37132870846765	-0.403149522051203	0.988896103637201	2.74203048321769	2.01385099722972	-0.140072199973844	3.44616474806045	2.51930218795901	3.20874796725182	2.30519977886910	1.28315005804109];


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

%% 画图：天线波束方向图
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
          w2=ones(M,1);
%          a2=exp(-j*2*pi/c*(-Delta_f'*T(m)*c-D'*f0*sin(theta(n))+Delta_f'*R0)); %导向矢量
%          w2=exp(-j*2*pi/c*(-Delta_f'*T(1)*c-D'*f0*sin(theta0)+Delta_f'*R0)); 
        % w2=ones(12,1);
        P2(n,m) =dot(w2,a2);
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
          w3=ones(M,1);
%         Delta_f=TMLFO(f0,d,c,M,theta0,R0,T(m));
%          a3=exp(-j*2*pi/c*(-Delta_f'*T(m)*c+Delta_f'*R(n)-D'*f0*sin(theta0))); %导向矢量
%          w3=exp(-j*2*pi/c*(-Delta_f'*T(1)*c+Delta_f'*R0-D'*f0*sin(theta0))); 
        P3(n,m) =dot(w3,a3);
    end
 end
%% 画图：时间距离维波束方向图
% P3=P3';
figure(3); 
imagesc(T,R,abs(P3)/max(max(abs(P3)))); 
ylabel('R/m'); xlabel('时间/s'); 
axis tight; axis xy;
title('');
colorbar;
