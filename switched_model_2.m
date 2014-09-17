 clear all
 clc
p1=.6;
i1=1.2;
d1=-0.05;
v1=1;
n1=1;
e1=.0000001;
s=tf('s');
K_PID_1=p1+i1/(s+e1)+d1*(n1/(1+n1/s));
K_h=(0.0965*s^2+2.023*s+21.84)/(s^3+1200*s^2+7.201e05*s+1.152e04);
P=(v1*1.8e08)/(s^2+20.96*s+226.3);
e2ref1=(1/(1+K_PID_1*K_h*P));
[num,den]=tfdata(e2ref1);
num=num{1,1};
den=den{1,1};
[A, B, C, D]=tf2ss(num,den);
P=lyap(A,eye(7));
lyp=A'*P+P*A;
eig(lyp)

e1=.0000001;
n1=1;


i=0;
j=0;
k=0;
for p1=.55:.02:.75
    j=j+1;
    disp(j)
    for i1=1:.2:3.2
        for d1=-0.07:.01:0
            for v1=.8:.1:1.2
                i=i+1;
                K_PID_1=p1+i1/(s+e1)+d1*(n1/(1+n1/s));
                K_h=(0.0965*s^2+2.023*s+21.84)/(s^3+1200*s^2+7.201e05*s+1.152e04);
                P=(v1*1.8e08)/(s^2+20.96*s+226.3);
                e2ref1=(1/(1+K_PID_1*K_h*P));
                [num,den]=tfdata(e2ref1);
                num=num{1,1};
                den=den{1,1};
                [A, B, C, D]=tf2ss(num,den);
                lyp=A'*P+P*A;
                
                if eig(lyp)<0
                    k=k+1;
                    result(1:5,i)=[p1 i1 d1 v1 1]; %#ok<*SAGROW>
                else
                    result(1:5,i)=[p1 i1 d1 v1 0];
                end
            end
        end
    end
end