clear all
close all


% G�n�ration de donn�e pour le filtre de Kalman
% Initialisation

% nb de step
N = 100 ;

% donn�es � g�n�rer :
% X en m, position r�elle
X = zeros(N,1);
% VX en m/s, vitesse r�elle
VX = zeros(N,1);
% AX en m/s�, acc�l�ration r�elle
AX = zeros(N,1);
% X_GPS en m
X_GPS = zeros(N,1);
% X_TAG en m
X_TAG = zeros(N,1);
% X_ODOM en m
X_ODOM = zeros(N,1);
% X_TUM en m
X_TUM = zeros(N,1);


% Y en m, position r�elle
Y = zeros(N,1);
% VY en m/s, vitesse r�elle
VY = zeros(N,1);
% AY en m/s�, acc�l�ration r�elle
AY = zeros(N,1);
% Y_GPS en m
Y_GPS = zeros(N,1);
% Y_TAG en m
Y_TAG = zeros(N,1);
% Y_ODOM en m
Y_ODOM = zeros(N,1);
% Y_TUM en m/s
Y_TUM = zeros(N,1);



% Utilisation de la fonction randn() pour simuler les erreurs de mesure.
% Generate values from a normal distribution with mean 1 and standard
%        deviation 2.
%           r = 1 + 2.*randn(100,1);

% donn�es � g�n�rer :
% X en m
% X_GPS en m
% X_TAG en m
% X_ODOM en m
% X_TUM en m
% de m�me pour Y

%g�n�ration de l'acc�l�ration r�elle
for j = 1 : N/5
    AX(j,1) = 2.5/(N/5) ; 
    AY(j,1) = -2.5/(N/5) ; 
end

for j = 1 + N/5  : N-(N/5)
    AX(j,1) = 0 ;
    AY(j,1) = 0 ;
end

for j = 40 : 50
    AY(j,1) = -2.5/(N/5) ; 
end

for j = 1 + N-(N/5)  : N
    AX(j,1) = -2.5/(N/5) ;
    AY(j,1) = +2.5/(N/5) ;
end

%g�n�ration de la vitesse et de la position r�elle
for j = 2 : N
    VX(j,1) = VX(j-1,1)+AX(j,1);  
    VY(j,1) = VY(j-1,1)+AY(j,1);  
    X(j,1) = X(j-1,1)+VX(j,1);
    Y(j,1) = Y(j-1,1)+VY(j,1);
end

%g�n�ration des bruits de mesure
ErreurGPS = 20; 
ErreurTAG = 1;
ErreurODOM = 5;
ErreurTUM = 3;



X_GPS = X - ErreurGPS*rand(N,1);
Y_GPS = Y + ErreurGPS*rand(N,1);
for j = 50 : 1 : N
    X_GPS(j,1) = -1000000;
    Y_GPS(j,1) = -1000000;
end


X_ODOM = X + ErreurODOM*randn(N,1);
Y_ODOM = Y + ErreurODOM*randn(N,1);


X_TUM = X + ErreurTUM*randn(N,1);
Y_TUM = Y + ErreurTUM*randn(N,1);




% On simule la detection d'un TAG tout les 30 m

for j = 1 : 1 : N
    X_TAG(j,1) = -1000000;
    Y_TAG(j,1) = -1000000;
end

for j = 1 : 30 : N
    X_TAG(j,1) = X(j,1) + ErreurTAG*randn(1,1);
    Y_TAG(j,1) = Y(j,1) + ErreurTAG*randn(1,1);
end






%plot
figure(1)
subplot (1,1,1), plot(X,'b')
xlabel('Temps');
ylabel('Position X');
hold on
subplot (1,1,1), plot(X_GPS, 'r')
hold on
subplot (1,1,1), plot(X_TAG, 'c')
hold on
subplot (1,1,1), plot(X_ODOM, 'g')
hold on
subplot (1,1,1), plot(X_TUM, 'y')
legend('reel','gps','tag','odom','Tum')


% 
% 
figure(2)
subplot (1,1,1), plot(Y,'b')
xlabel('Temps');
ylabel('Position Y');
hold on
subplot (1,1,1), plot(Y_GPS, 'r')
hold on
subplot (1,1,1), plot(Y_TAG, 'c')
hold on
subplot (1,1,1), plot(Y_ODOM, 'g')
hold on
subplot (1,1,1), plot(Y_TUM, 'y')
legend('reel','gps','tag','odom','Tum')




