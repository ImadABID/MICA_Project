function  is_ventricular_fibrillation =  ventricular_fibrillation(Sig)

%% the patient has  ventricular fibrillation  if the function returns 1, otherwise,the patient does not have a  ventricular fibrillation

%BPM    
bpm = cardiac_rhythm(Sig);

%%time
T = max(0:1/Sig.Fs:(length(Sig.ecg)-1)*1/Sig.Fs);
time = floor(T/100)*100;

N_fft = 1024;

min_index = floor((time/2.5)*Sig.Fs);
max_index = floor((time/2.5 +10 )*Sig.Fs);

VF_fourrier = fftshift(abs(fft(Sig.ecg(min_index:1:max_index),N_fft)));

%thresholding
seuil = max(VF_fourrier)*0.8;
VF_th_1 = VF_fourrier >= seuil;

nb_of_max = sum(VF_th_1);

fprintf("nb of max  : %d \n" ,nb_of_max);

if( (nb_of_max <= 4) && (bpm >= 240 && bpm <=600))
    is_ventricular_fibrillation=1;
else
     is_ventricular_fibrillation=0;
end

end