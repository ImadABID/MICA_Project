function [R_locations] = wave_detection_R(ECG,Ts,window_length)

%% Passe bas
coeff_nume_bas = conv([1 0 0 0 0 0 -1],[1 0 0 0 0 0 -1]); %les coefficients du numérateur de la transformeé en z du filter passe_bas
coeff_denom_bas = [1 -2 1];

y_bas=filter(coeff_nume_bas,coeff_denom_bas,ECG);

%% Passe haut
coeff_nume_haut = zeros(1,33);%les coefficients du numérateur de la transformeé en z du filter passe_bas
coeff_nume_haut(1,1)=-1;
coeff_nume_haut(1,17)=32;
coeff_nume_haut(1,18)=-32;
coeff_nume_haut(1,33)=1;
coeff_denom_haut =[1,-1];

sig_band_pass=filter(coeff_nume_haut,coeff_denom_haut,y_bas);

retard_pass_bande = delay_between_2_sigs(sig_band_pass, y_bas);
%fprintf("Delay band-pass : %d\n", retard_pass_bande);
ECG = ECG(1:1:length(ECG)-retard_pass_bande);
sig_band_pass = sig_band_pass(retard_pass_bande:1:length(sig_band_pass));

%% Derivation
y_derivated= filter([1,2,0,-2,-1], [1], sig_band_pass).*(1/(8*Ts));
retard_derivation = delay_between_2_sigs(y_derivated, sig_band_pass);
%fprintf("Delay derivation : %d\n", retard_derivation);
ECG = ECG(1:1:length(ECG)-retard_derivation);
sig_band_pass = sig_band_pass(1:1:length(sig_band_pass)-retard_derivation);
y_derivated = y_derivated(retard_derivation:1:length(y_derivated));

%% Squaring
S_sq = abs(y_derivated(retard_derivation:1:length(y_derivated))).^2;
S_mwi = moving_window_intergration(S_sq,window_length);

%% Thresholding
thresholding_step = thresholding(S_mwi);

%% Detecting R
%fprintf("length(thresholding_step) : %d\n", length(thresholding_step));
%fprintf("length(sig_band_pass) : %d\n", length(sig_band_pass));

%signal_to_extract_R = thresholding_step .* sig_band_pass;


R_locations = zeros(1,100);

figure,
nb_values = 3000;
nbr_figures = 6;

subplot(5,1,1);
plot(ECG(1:nb_values));
title('ECG');
xlabel("time")
ylabel("ECG en mV")
grid on ;

subplot(nbr_figures,1,2);
plot(sig_band_pass(1:nb_values));
title('ECG after band-pass filtre');
xlabel("time")
ylabel("magnitude")
grid on ;

subplot(nbr_figures,1,3);
plot(y_derivated(1:nb_values));
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

