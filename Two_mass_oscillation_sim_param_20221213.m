clear; close all; clc;
n = 1;
w = 100;

%% Electrical Param.
Iq_MAX = 30; %A
Pole = 10;
PP = Pole/2;
Kt = 0.169; %Nm/A
Flux_PM = Kt/(3/2)/PP; % 
Ls = 1.64/2/1000; %H
Ld = Ls; 
Lq = Ls;
Rs = 0.26/2; % Ohm
BW_current = 2000*2*pi;

Kp_dc = BW_current*Ls;
Ki_dc = BW_current*Rs;

Kp_qc = BW_current*Ls;
Ki_qc = BW_current*Rs;

Ts_10k = 0.0001;
%% position loop
Kp_pos = 5*2*pi;

%% Mechanicalk parameters
Speed_MAX = 1500/60*2*pi; % rad/s
Ts_1k = 0.001;
J1 = 38000;
J2 = 0.1*n*J1; %30
B1 = 0.5*J1;
B2 = 0.01*J2;
K = 10*J1; %1

BW_Speed = 2*pi*1*w;
Kp_Speed = (J1+J2)*BW_Speed;
Ki_Speed = B1*BW_Speed;
Kd_Speed = 0;%BW_Speed/100000;
% Kp_pos = 1*2*pi;

%% DID controller
BW_obv = 100*2*pi; %rad/s
Damp_obv = 1.016667;
Kp_obv = 3*BW_obv^2*Damp_obv*(J1+J2);
Ki_obv = (J1+J2)*BW_obv^3;
Kd_obv = 3*Damp_obv*BW_obv;

open('Two_mass_Osillation.slx'); 
sim('Two_mass_Osillation.slx');
w = 2.5; % width (max = 3.25)
l = 2; % length (max = 12.2)
d = (2*(max(ans.relative_distance.Data))*J2+l*J2)/(1600*w*l^2)+0.3; % depth (max = 4.2)
water_d = J2/1600/(w*l); % Density of Nitroglycerin = 1600 kg/m^3
center_point = ans.relative_distance.Data;
h = 2*center_point*water_d/l;


for k = 1:50:length(ans.relative_distance.Data)
    x1 = -l/2;      y1 = water_d-h(k);
    x2 = l/2; y2 = water_d+h(k);
    plot([x1,x2],[y1,y2],'LineWidth',2,'Color','b');hold on;
    plot([-l/2,-l/2],[0,d],'LineWidth',2,'Color','k'); hold on;
    plot([l/2,l/2],[0,d],'LineWidth',2,'Color','k'); hold on;
    plot([-l/2,l/2],[0,0],'LineWidth',2,'Color','k'); hold on;
    xlim([x1-1 x2+1]); ylim([0,d+1]);
    pause(0.00001);
    hold off;
    
end
