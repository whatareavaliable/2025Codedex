clear;
w=11.61;         %wInP=9.61or9.52, wInGaAs=11.61or11.57, wInAlAs=9.94or9.84
N=8e18*1e6;     %doping [/m^3]
wl=13e-6;     %wavelength[m]
m=0.043;         %InP=0.073/0.079, InGaAs=0.043/0.04, InAlAs=0.072
tau=100*1e-15;    %100fs
omega=2*pi*(3e8)/wl;

wp2=N*(1.602e-19)^2/(8.8542e-12)/w/(9.10938e-31*m);
wp=sqrt(wp2);
wl_wp=3e8/wp;
re=abs(w*(1-wp2/(omega^2+(1/tau^2))));
im=w*wp2*tau/(omega+omega^3*tau^2);
n=sqrt(re+1i*im);