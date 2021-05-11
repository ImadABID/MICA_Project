function [outputArg1,outputArg2] = R_wave_detection(ECG,Ts)

coeff_nume_bas = conv([1 0 0 0 0 0 -1],[1 0 0 0 0 0 -1]); %les coefficients du numérateur de la transformeé en z du filter passe_bas
coeff_denom_bas = [1 -2 1];

[y_bas,zf1]=filter(coeff_nume_bas,coeff_denom_bas,ECG);

coeff_nume_haut = zeros(1,33);%les coefficients du numérateur de la transformeé en z du filter passe_bas
coeff_nume_haut(1,1)=-1;
coeff_nume_haut(1,17)=32;
coeff_nume_haut(1,18)=-32;
coeff_nume_haut(1,33)=1;

coeff_denom_haut =[1,-1];

[y_final,zf2]=filter(coeff_nume_haut,coeff_denom_haut,y_bas);

y_derivated = filter(1/(8*Ts)*[1,2,0,-2,-1],[0,0,1]



end

