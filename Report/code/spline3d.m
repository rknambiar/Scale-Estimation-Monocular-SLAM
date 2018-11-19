%############# Initialize #################
clear all
clear
n=20 % Points to be considered in curve
t=linspace(0,5,n) % equal spacing of points

%############ Noise #######################

noisex=5*(rand(1,n)-0.5) %noise in x
noisey=5*(rand(1,n)-0.5) %noise in y
noisez=5*(rand(1,n)-0.5) %noise in z

%######### Noisy Data ####################

X=3.*t.^2 + 5.*t + 2 + noisex %noisy data in x
Y=2.*t.^2 + 7.*t + 2 + noisey %noisy data in y
Z=3.*t.^2 + 4.*t + 2 + noisez %noisy data in z
%######## Summation matrix ###############

S4=t.^3*transpose(t) % t^4 terms sum
S3=t.^2*transpose(t) % t^3 terms sum
S2=t*transpose(t) % t^2 terms sum
S1=t*ones(n,1) % X terms sum

%###### Least Square matrix #############
%   AX=B
A=[S4 S3 S2;  %A matrix for computing X matrix
   S3 S2 S1;
   S2 S1 1]

Bx=[X*transpose(t.^2);X*transpose(t);Y*ones(n,1)] %B in x
By=[Y*transpose(t.^2);Y*transpose(t);Y*ones(n,1)] %B in y
Bz=[Z*transpose(t.^2);Z*transpose(t);Z*ones(n,1)] %B in z

Constantx=inv(A)*Bx % by least square method x
Constanty=inv(A)*By % by least square method y
Constantz=inv(A)*Bz % by least square method z

%#Computing value of new co-ordinates#

Ylinex=Constantx(1,1).*t.^2 + Constantx(2,1).*t + Constantx(3,1) %X point
Yliney=Constanty(1,1).*t.^2 + Constanty(2,1).*t + Constanty(3,1) %Y point
Ylinez=Constantz(1,1).*t.^2 + Constantz(2,1).*t + Constantz(3,1) %Z point

errorx= X-Ylinex % error in x
errory= Y-Yliney % error in y
errorz= Z-Ylinez % error in z

error = abs(((errorx).^2 + errory.^2 + errorz.^2).^(0.5)) % final error
%############# Plots ##################
figure;
plot3(X,Y,Z,'o-b');grid; %plot of noisy data
hold on
plot3(Ylinex,Yliney,Ylinez,'--r');grid; %plot of least square data
figure;
plot(t,error,'-g');grid; % Error wrt to time
figure;
plot(X,t,'--b')
%############ Velocity ##############

Vx=6.*t + 5 %velcity data in x
Vy=4.*t + 7 %velcity data in y
Vz=6.*t + 4 %velcity data in z
figure;
plot(t,Vx,'-g',t,Vy,'-r',t,Vz,'-b');grid;
