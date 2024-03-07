%Poređenje CST i Matlaba za promenu W



hold on;
figure(1);
p = 22e-3; 
l = p/2;                 % perioda jedinične ćelije
Er = 9.8;
d = 1.27e-3;             % visina dielektrične podloge
Ws = 3e-3;
W = [4e-3, 6e-3, 8e-3];
c = 3e8;
f = 0:1e8:25e9;
beta_d = zeros(length(f));
b = 1;

Ee_Ws = ((Er+1)/2) + (((Er-1)/2)*(1/(sqrt(1+((12*d)/Ws)))));
if Ws/d <= 1
    Z0_Ws = (60/sqrt(Ee_Ws)) * log(((8*d)/Ws) + (Ws/(4*d)));
else
    Z0_Ws = (120*pi)/(sqrt(Ee_Ws)*(Ws/d + 1.393 + 0.667 * log((Ws/d) + 1.444)));
end

for j = W

Ee_W = ((Er+1)/2) + (((Er-1)/2)*(1/(sqrt(1+((12*d)/j)))));
if j/d <= 1
    Z0_W = (60/sqrt(Ee_W)) * log(((8*d)/j) + (j/(4*d)));
else
    Z0_W = (120*pi)/(sqrt(Ee_W)*(j/d + 1.393 + 0.667 * log((j/d) + 1.444)));
end

for i = f

    beta_W = ((2*pi*i)/c)*sqrt(Ee_W);
    ABCD_W = [cos(l*beta_W) 1i*Z0_W*sin(beta_W*l); 1i*(1/Z0_W)*sin(beta_W*l) cos(beta_W*l)];
    %-------------------------------------------------------------------------------
    beta_Ws = ((2*pi*i)/c)*sqrt(Ee_Ws);
    ABCD_Ws = [cos(l*beta_Ws) 1i*Z0_Ws*sin(beta_Ws*l); 1i*(1/Z0_Ws)*sin(beta_Ws*l) cos(beta_Ws*l)];

    ABCD = ABCD_W * ABCD_Ws;
    beta_d(b) = imag(acosh((ABCD(1,1) + ABCD(2,2))/2));
    b = b + 1;
end
plot(beta_d, f);
end
grid
colororder(["#FF0000", "#00FF00", "#0000FF"])
%title("k-beta dijagram mikrostrip linije sa promenom w")
xlabel("beta*d [rad/m]")
xlim([0 4])
ylim([0 5e9])
ylabel("f [Hz]")
legend('w (numerička) = 4 mm', 'w (numerička) = 6 mm', 'w (numerička) = 8 mm')

data2 = readtable('22 3 4.txt');
T21 = data2{:,1}; 
T22 = data2{:,2};

data3 = readtable('22 3 6 (1).txt');
T31 = data3{:,1}; 
T32 = data3{:,2};

data4 = readtable('22 3 8.txt');
T41 = data4{:,1}; 
T42 = data4{:,2};
plot (T21/58,T42*1e9,'*', 'Color','r', 'DisplayName', 'w (analitička) = 4 mm');
plot (T21/58,T22*1e9,'O', 'Color','g', 'DisplayName', 'w (analitička) = 6 mm');
plot (T21/58,T32*1e9,'x', 'Color','b', 'DisplayName','w (analitička) = 8 mm');
hold off;