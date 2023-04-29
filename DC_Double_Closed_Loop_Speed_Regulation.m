clear;
%电机参数
UN=500;     %额定电压
IdN=9.09;  %额定电流
nN=1500;    %额定转速
Ce=0.1459;  %反电势系数
lambda=1.5; %过载倍数
R=3.68;     %电枢电阻
Tl=0.0144;  %电磁时间常数
Tm=0.18;    %机电时间常数

%PWN变换器参数
f=8000;    %PWM开关频率
Ts=1/f;    %延迟时间
Ucm=5;     %最大控制电压
Udc=495;   %直流母线电压
Ks=Udc/Ucm;%放大系数

%电流环滤波时间
Toi=0.0005;

%转速环滤波时间常数
Ton=0.01;

%额定转速给定电压
Un=10;

%转速调节器输出限幅值
Uonl=10;

%电流调节器输出限幅
Uoil=5;

%转速环反馈系数
alpha=Un/nN;

%电流环反馈系数
beta=Uonl/(lambda*IdN);

%电流调节器
Tsigmai=Ts+Toi;  %电流环小时间常数之和
taui=Tl;
KI=0.5/Tsigmai;  %电流环开环增益
Ki=KI*taui*R/(Ks*beta);  %ACR比例系数

%转速调节器
Tsigman=1/KI+Ton;  %转速环小时间常数之和
h=5;
taun=h*Tsigman;  %ASR超前时间常数
KN=(h+1)/(2*h*h*Tsigman*Tsigman);  %转速环开环增益
Kn=(h+1)*beta*Ce*Tm/(2*h*alpha*R*Tsigman);  %ASR比例系数