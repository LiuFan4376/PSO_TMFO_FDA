function a = tmfo_AF(g,theta0,R0,theta,R,t)
%TMFO_AF 时间调制频偏FDA的导向矢量

j=sqrt(-1);
[N,M]=size(g);
f0=2e9; %载波中心频率
c=3e8;        %光速
lamda=c/f0;  %波长
d=lamda/2;    %阵元间距
if N==1
D=d*(0:M-1);
Delta_f=(g-f0*D*sin(theta0)/c)/(t-R0/c);
a=exp(j*2*pi*(Delta_f'*(t-R/c)+f0*D'*sin(theta)/c)+j*(-2*pi*g'));
else
   D=ones(N,M);
   for i=1:N
    D(i,:)=(0:M-1)*d;
   end
   Delta_f=(g-f0*D*sin(theta0)/c)/(t-R0/c);
   a=exp(j*2*pi*(Delta_f'*(t-R/c)+f0*D'*sin(theta)/c)+j*(-2*pi*g'));
end
end

