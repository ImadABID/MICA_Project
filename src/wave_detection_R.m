function [R_locations] = wave_detection_R(ECG,Ts,window_length)

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
y_final = y_final(20:1:length(y_final));
y_derivated= filter([1,2,0,-2,-1],[1],y_final).*(1/(8*Ts));

S_sq = abs(y_derivated(10:1:length(y_derivated))).^2;
S_mwi = moving_window_intergration(S_sq,window_length);
thresholding_step = thresholding(S_mwi);

R_locations = zeros(1,100);

figure,
nb_values = 6000;
nbr_figures = 6;

%time_ecg = linspace(1,Ts,X);

subplot(5,1,1);
plot(ECG(1:nb_values));
title('ECG');
xlabel("time")
ylabel("ECG en mV")
grid on ;

subplot(nbr_figures,1,2);
plot(y_final(1:nb_values));
title('ECG after band-pass filtre');
xlabel("time")
ylabel("magnitude")
grid on ;

subplot(nbr_figures,1,3);
plot(y_derivated(10:nb_values));
title('ECG Derivated');
xlabel("time")
ylabel("magnitude")
grid on;

subplot(nbr_figures,1,4);
plot(S_sq(1:nb_values));
title('ECG module carre');
xlabel("time")
ylabel("magnitude")
grid on;

subplot(nbr_figures,1,5);
plot(S_mwi(1:nb_values));
title('ECG MWI');
xlabel("time")
ylabel("magnitude")
grid on ;

subplot(nbr_figures,1,6);
plot(thresholding_step(1:nb_values));
title("After thresholding");
xlabel("time")
ylabel("magnitude")
grid on ;

end

