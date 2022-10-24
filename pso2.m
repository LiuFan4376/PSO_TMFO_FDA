function g = pso2(M)

lower_bound = 0;
higher_bound = M;
particle = 15;                            % ���Ӹ���
max_iteration = 200;                      % ��������
dimension = M;                            % ����λ�õ�ά�ȣ����Ա�������
c1 = 1.5;                                   % ���ٳ���1�����ƾֲ����Ž�
c2 = 1.5;                                   % ���ٳ���2������ȫ�����Ž�
w = 0.6;                                  % ��������
w_max = 0.9; w_min = 0.4;            % ��Ȩϵ��
vmax =log( M);                               % �ٶ����ֵ
vmim=-log(M);
precision=1e-4;                          % ��������



%% -------------------------------------------------��ʼ��
x =log(M)*(rand(particle,M)-rand(particle,M)); %����Ⱥ��
% x(1,:)=[-0.968582698429425	-0.227707079709352	1.37767146019955	0.0369431647179233	1.88532213650533	2.94838930810703	0.996508864223969	3.34953080749486	-0.418920118197085	0.962259914939033	2.71719104357755	2.00157311244277	-0.159347461591712	3.42794251951280	2.50158014796904	3.18877152836014	2.28382402547958	1.25857580912241 ];
v =log(M)*rand(particle,dimension);                                       %�ٶȾ���
disp(x);
Pbest_x=x;                                % ����ʼλ������Ϊ�ֲ����Ž��λ��
Pbest_y= cost_function1(x);                 % �����ֲ��������ӵĴ��ۺ���ֵ
Gbest_x = x(1,:);                         % ��ʼȫ������λ���趨Ϊ��һ�����ӵ�λ��
Gbest_y=inf;                              % ȫ�����Ž����ӵĴ��ۺ���ֵ
k=1;
f=zeros(particle,1);
data=zeros(1,max_iteration);
%% -------------------------------------------------����
while k<=max_iteration
    flagx=Gbest_x;
    flagy=Gbest_y;
    
    % ��Ѱ�������ӵľֲ�����
    for i=1:particle
        f(i) =  cost_function1(x(i,:));
        if f(i)<Pbest_y(i)
            Pbest_y(i)=f(i);      % Personal best function value
            Pbest_x(i,:)=x(i,:);    % Personal best variable
        end
    end
    
    % ����ȫ������λ�ü���Ӧֵ
    [Gbest_y,index] = min(Pbest_y);
    Gbest_x = x(index,:);
    w = w_max-(w_max-w_min)*k/max_iteration;
    % ÿһ����Ѱ֮��������ӵ��ٶȼ�λ��
    for n=1:particle
        v(n,:)=w*v(n,:)+c1*rand()*(Pbest_x(n,:)-x(n,:))+c2*rand()*(Gbest_x-x(n,:));

        % �ٶ�Խ�����
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
%     str1=['��',k,'�ε�����'];
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


