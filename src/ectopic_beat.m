function  is_ectopic_beat = ectopic_beat(Sig)

%% the patient has ectopic beat if the function returns 1, otherwise,the patient does not have an ectopic beat

epsilon = 1; %s

[P, Q, R, S, T] = wave_detection_PQRST(Sig.ecg, 1/(Sig.Fs), 2, 'no plot');
N = length(R);
delta_R_1 = [];
delta_R_2 = [];

for i=1:1:N-1
    diff_1 = R(i+1)-R(i);
    delta_R_1 = [delta_R_1,diff_1];
end

L = length(delta_R_1);

for j= 1:1:L-1
    diff_2 =  abs(delta_R_1(j+1)-delta_R_1(j));
    delta_R_2 = [delta_R_2,diff_2];
end

 delta_R_2= delta_R_2 *1/Sig.Fs;
 
 max_delta_R_2 = max(delta_R_2);
 
 if( max_delta_R_2 > epsilon )
     is_ectopic_beat = 1;
 else
     is_ectopic_beat = 0;


end

    



