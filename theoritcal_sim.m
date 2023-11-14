clc;clear all;close all;

J1 = 3.8E4; %M1
J2 = 0.1*J1; %M2
B1 = 0.5*J1; %C1
B2 =  0.01*J2; %C2
K = 10*J1; %1
BW_Speed = 2*pi*1;
Kp = (J1+J2)*BW_Speed;
Ki = B1*BW_Speed;


sys1 = tf([J2*Kp J2*Ki+Kp*B2 Ki*B2+K*Kp Ki*K],[0.1*J1*J2 J1*B2+J2*B1+B2*J2+J2*Kp J1*K+B1*B2+J2*K+Kp*B2+Ki*J2 K*B1+K*Kp+Ki*B2 K*Ki]);
sys2 = tf([Kp*B2 Kp*K+Ki*B2 Ki*K],[0.1*J1*J2 J1*B2+J2*B1+B2*J2+J2*Kp J1*K+B1*B2+J2*K+Kp*B2+Ki*J2 K*B1+K*Kp+Ki*B2 K*Ki]);
t1 = 0:0.01:10-0.01;
syms t;
u(t) = piecewise(t < 4,10 * t,t >= 4,40);
tvalue = linspace(0,10,1000);
uvalue = double(subs(u(tvalue)));
y1 = lsim(sys1,uvalue,t1);
y2 = lsim(sys2,uvalue,t1);
figure(1);
plot(tvalue,y1,'r','LineWidth',1);
hold on
plot(tvalue,y2,'g','LineWidth',1);
grid on
grid minor
hold on
plot(tvalue,uvalue,'k--','LineWidth',2);
title('Theoretical Solution','fontsize',18);
legend('$\dot{x_1}(t)$','$\dot{x_2}(t)$','Interpreter','latex','fontsize',14);
xlabel('Time [sec]','Interpreter','latex','fontsize',12);
ylabel('Velocity [m/s]','Interpreter','latex','fontsize',12);
hold off
figure(2);
h = bodeplot(sys2);
P1 = pole(sys1);
P2 = pole(sys2);