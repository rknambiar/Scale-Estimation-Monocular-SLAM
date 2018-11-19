clear all
clear
n=60; % Points to be considered in curve
X=linspace(1,15,n); % equal spacing of points
noise=(10)*(rand()-0.5);  % noise in data from -1 to 1
Y=(0.1).*X.^3 - (1.5)*X.^2 + (6).*X + noise; % noisy output

Camerax=[2 4 6 8 12 14 ]
Cameray=[0 10 -5 20 20 80]
Scale1=0.5
Scale2=0.5
Scale3=0.1
%############# Without section ################

Xn=linspace(1,15,n);
S4=Xn.^3*transpose(Xn); % X^4 terms sum
S3=Xn.^2*transpose(Xn); % X^3 terms sum
S2=Xn*transpose(Xn); % X^2 terms sum
S1=Xn*ones(n,1); % X terms sum
%   AX=B 
An=[S4 S3 S2;   
   S3 S2 S1;
   S2 S1 1];

Bn=[Y*transpose(Xn.^2);Y*transpose(Xn);Y*ones(n,1)];
Constant1 = inv(An)*Bn; % by least square method

Ylinen=(Constant1(1,1).*Xn.^2 + Constant1(2,1).*Xn + Constant1(3,1)) ;
errorn=Y-Ylinen; % Error term in actual and computed

%################Section wise ##################

%for first section
X1=linspace(1,5,n/3);

S4=X1.^3*transpose(X1); % X^4 terms sum
S3=X1.^2*transpose(X1); % X^3 terms sum
S2=X1*transpose(X1); % X^2 terms sum
S1=X1*ones(n/3,1); % X terms sum

%   AX=B 
A1=[S4 S3 S2;   
   S3 S2 S1;
   S2 S1 1];

B1=[Y(1:n/3)*transpose(X1.^2);Y(1:n/3)*transpose(X1);Y(1:n/3)*ones(n/3,1)];
ConstCamera1=inv([Camerax(1,1) 1;Camerax(1,2) 1])*[Camerax(1,1);Camerax(1,2)];
Constant1=inv(A1)*B1; % by least square method

Yline1=(Constant1(1,1).*X1.^2 + Constant1(2,1).*X1 + Constant1(3,1))+ Scale1*(ConstCamera1(1,1)*X1+ConstCamera1(2,1));
error1=Y(1:n/3)-Yline1; % Error term in actual and computed

%################################################################
%for second section
X2=linspace(5,10,n/3);

S4=X2.^3*transpose(X2); % X^4 terms sum
S3=X2.^2*transpose(X2); % X^3 terms sum
S2=X2*transpose(X2); % X^2 terms sum
S1=X2*ones(n/3,1); % X terms sum

%   AX=B 
A2=[S4 S3 S2;   
   S3 S2 S1;
   S2 S1 1];

B2=[Y(((n/3)+1):2*n/3)*transpose(X2.^2);Y(((n/3)+1):2*n/3)*transpose(X2);Y(((n/3)+1):2*n/3)*ones(n/3,1)];
ConstCamera2=inv([Camerax(1,3) 1;Camerax(1,4) 1])*[Camerax(1,3);Camerax(1,4)];
Constant2=inv(A2)*B2; % by least square method

Yline2=(Constant2(1,1).*X2.^2 + Constant2(2,1).*X2 + Constant2(3,1))+Scale2*(ConstCamera2(1,1)*X1+ConstCamera2(2,1));
error2=Y(((n/3)+1):2*n/3)-Yline2; % Error term in actual and computed

%################################################################

%for third section
X3=linspace(10,15,n/3);

S4=X3.^3*transpose(X3); % X^4 terms sum
S3=X3.^2*transpose(X3); % X^3 terms sum
S2=X3*transpose(X3); % X^2 terms sum
S1=X3*ones(n/3,1); % X terms sum

%   AX=B 
A3=[S4 S3 S2;   
   S3 S2 S1;
   S2 S1 1];

B3=[Y(((2*n/3)+1):n)*transpose(X3.^2);Y(((2*n/3)+1):n)*transpose(X3);Y(((2*n/3)+1):n)*ones(n/3,1)];
ConstCamera3=inv([Camerax(1,5) 1;Camerax(1,6) 1])*[Camerax(1,5);Camerax(1,6)];
Constant3=inv(A3)*B3; % by least square method

Yline3=(Constant3(1,1).*X3.^2 + Constant3(2,1).*X3 + Constant3(3,1))+Scale3*(ConstCamera3(1,1)*X1+ConstCamera3(2,1));
error3=Y(((2*n/3)+1):n)-Yline3; % Error term in actual and computed

%############### Graph section ###################

error=[error1 error2 error3 ];
Yline=[Yline1 Yline2 Yline3];
Xf=[X1 X2 X3];
figure;
hold on
plot(Xf,Yline,'-or')
plot(X,Y,'+-b',Xn,Ylinen,'-og');grid;
plot(Camerax,Cameray,'*k')
figure;
plot(X,abs(error),'-g',X,abs(errorn),'-r');grid;
