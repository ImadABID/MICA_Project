function [R_locations] = wave_detection_R(ECG,Ts,nb_values,window_length)

coeff_nume_bas = conv([1 0 0 0 0 0 -1],[1 0 0 0 0 0 -1]); %les coefficients du numérateur de la transformeé en z du filter passe_bas
coeff_denom_bas = [1 -2 1];
%ECG = [[0 0 ] ,ECG,[0 0]];
y_bas=filter(coeff_nume_bas,coeff_denom_bas,ECG);
%y_bas = [[0 0 ], y_bas,[0 0]];

coeff_nume_haut = zeros(1,33);%les coefficients du numérateur de la transformeé en z du filter passe_bas
coeff_nume_haut(1,1)=-1;
coeff_nume_haut(1,17)=32;
coeff_nume_haut(1,18)=-32;
coeff_nume_haut(1,33)=1;

coeff_denom_haut =[1,-1];

y_final=filter(coeff_nume_haut,coeff_denom_haut,y_bas);
retard_pass_bande = 20;
y_final = y_final(retard_pass_bande:1:length(y_final));
y_derivated= filter([1,2,0,-2,-1],[1],y_final).*(1/(8*Ts));
retard_derivation = 10;

Ssq = abs(y_derivated(retard_derivation:1:length(y_derivated))).^2;

R_locations = zeros(1,100);

figure,


%time_ecg = linspace(1,Ts,X);

subplot(5,1,1);

%plot(time_ecg,ECG);
plot(ECG(1:nb_values));
title('ECG');
grid on ;

subplot(5,1,2);
plot(y_final(1:nb_values));
title('ECG pass bande');
grid on ;
subplot(5,1,3);
plot(y_derivated(retard_derivation:nb_values));
title('ECG Derivated');
grid on;
subplot(5,1,4);
plot(Ssq(1:nb_values));
title('ECG module carre');
grid on;
subplot(5,1,5);
grid on ;
X = moving_window_intergration(Ssq,window_length);
plot(X(1:nb_values));
title('ECG MVI');
grid on ;


end

