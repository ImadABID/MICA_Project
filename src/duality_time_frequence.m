clc;
clear all;
close all;

fmin = 50;  %Hz
df = 0.1; %Hz
Te = 10e-4;
signal_size = 500;

t = Te .* (0:1:signal_size-1);

f_rise_start = floor(0.5*signal_size);

f = [ones(1, f_rise_start), (fmin:df:fmin+df*(signal_size-f_rise_start-1))];

x = sin(2*pi.*f.*t);
x1 = sin(2*pi*fmin*t);

spectro(x, hann(20), 10, 1024, 1/Te, 'Short window');
spectro(x, hann(80), 10, 1024, 1/Te, 'Large window');