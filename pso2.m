function g = pso2(M)

lower_bound = 0;
higher_bound = M;
particle = 15;                            % 粒子个数
max_iteration = 200;                      % 最大迭代数
dimension = M;                            % 粒子位置的维度，即自变量个数
c1 = 1.5;                                   % 加速常数1，控制局部最优解
c2 = 1.5;                                   % 加速常数2，控制全局最优解
w = 0.6;                                  % 惯性因子
w_max = 0.9; w_min = 0.4;            % 加权系数
vmax =log( M);                               % 速度最大值
vmim=-log(M);
precision=1e-4;                          % 精度设置



%% -------------------------------------------------初始化
x =log(M)*(rand(particle,M)-rand(particle,M)); %粒子群矩
% x(1,:)=[-0.968582698429425	-0.227707079709352	1.37767146019955	0.0369431647179233	1.88532213650533	2.94838930810703	0.996508864223969	3.34953080749486	-0.418920118197085	0.962259914939033	2.71719104357755	2.00157311244277	-0.159347461591712	3.42794251951280	2.50158014796904	3.18877152836014	2.28382402547958	1.25857580912241 ];
v =log(M)*rand(particle,dimension);                                       %速度矩阵
disp(x);
Pbest_x=x;                                % 将初始位置设置为局部最优解的位置
Pbest_y= cost_function1(x);                 % 各个局部最优粒子的代价函数值
Gbest_x = x(1,:);                         % 初始全局最优位置设定为第一个粒子的位置
Gbest_y=inf;                              % 全局最优解粒子的代价函数值
k=1;
f=zeros(particle,1);
data=zeros(1,max_iteration);
%% -------------------------------------------------迭代
while k<=max_iteration
    flagx=Gbest_x;
    flagy=Gbest_y;
    
    % 搜寻各个粒子的局部最优
    for i=1:particle
        f(i) =  cost_function1(x(i,:));
        if f(i)<Pbest_y(i)
            Pbest_y(i)=f(i);      % Personal best function value
            Pbest_x(i,:)=x(i,:);    % Personal best variable
        end
    end
    
    % 更新全局最优位置及适应值
    [Gbest_y,index] = min(Pbest_y);
    Gbest_x = x(index,:);
    w = w_max-(w_max-w_min)*k/max_iteration;
    % 每一次搜寻之后更新粒子的速度及位置
    for n=1:particle
        v(n,:)=w*v(n,:)+c1*rand()*(Pbest_x(n,:)-x(n,:))+c2*rand()*(Gbest_x-x(n,:));

        % 速度越界操作
        for p=1:dimension
            if v(n,p)>vmax
                v(n,p)=vmax;
            elseif v(n,p)<-vmax
                v(n,p)=-vmax;
            end
        end
        x(n,:)=x(n,:)+v(n,:);
        for j=1:M
            if x(n,j)>M
                x(n,j)=M;
            end
            if x(n,j)<-M
                x(n,j)=-M;
            end
        end
%         index1=find( x(n,:)>M);
%          l=length((index1));
%          if index1>0
%             x(n,index)=M*ones(1,l);
%          end
%          index2=find( x(n,:)<-M);
%          l=length((index2));
%          if index2>0
%             x(n,index)=-M*ones(1,l);
%          end
         
    end
%     str1=['第',k,'次迭代：'];
%     str2=['Gbestx:',Gbest_x];
%     str3=['Gbest_y:',Gbest_y];

    error1=sqrt(dot((flagx-Gbest_x),(flagx-Gbest_x)));
    error2=abs(flagy-Gbest_y);
    disp('-------------------------------------------------------------------------------------------------------------------------------');
    disp(k);
%     disp('Gbestx:');
%     disp(Gbest_x);
    disp('Gbest_y:');
    disp(Gbest_y);
    disp('error1:');
    disp(error1);
    disp('error2:')
    disp(error2);
     disp('');
     data(1,k)=error1;
    if error1<precision&&error2<precision
        break;
    end
        k=k+1;
 end
 g=Gbest_x;
end


