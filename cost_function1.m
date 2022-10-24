function result = cost_function1(g)


%COST_FUNCTION pso-tdmo算法的代价函数
%  找到undesired区域的波束方向图最大的峰值

%% ------雷达参数设置
[N,M]=size(g);
theta=(0:1:90)*pi/180; %测量角度向量
R=linspace(0,2e5,1000); %测量距离向量
R0 = 1e5; %天线指向目标的距离
theta0 = 30/180*pi;  %%天线指向目标的角度
result=zeros(N,1);
for i=1:1000
    for j=1:20
        a=non_liner_a(g,R(i),theta(j));
        w=non_liner_a(g,R0,theta0);
        for k=1:N
         P=abs(dot(a,w));
         temp = [result(k) P(k)];
        result(k)=max(temp);
        end
    end
    
end

for i=1:1000
    for j=40:91
        a=non_liner_a(g,R(i),theta(j));
        w=non_liner_a(g,R0,theta0);
         for k=1:N
         P=abs(dot(a,w));
         temp = [result(k) P(k)];
        result(k)=max(temp);
        end
    end
    
end
for i=1:410
    for j=20:40
         a=non_liner_a(g,R(i),theta(j));
        w=non_liner_a(g,R0,theta0);
        for k=1:N
         P=abs(dot(a,w));
         temp = [result(k) P(k)];
        result(k)=max(temp);
        end
    end
    
end
for i=590:1000
    for j=20:40
        a=non_liner_a(g,R(i),theta(j));
        w=non_liner_a(g,R0,theta0);
        for k=1:N
         P=abs(dot(a,w));
         temp = [result(k) P(k)];
        result(k)=max(temp);
        end
    end
    
end
end


