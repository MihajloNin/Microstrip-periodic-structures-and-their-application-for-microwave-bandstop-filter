%Poređenje CST i Matlaba za promenu Ws


hold on;
figure(1);
p = 22e-3; 
l = p/2;                 % perioda jedinične ćelije
Er = 9.8;
d = 1.27e-3;             % visina dielektrične podloge
Ws = [1.5e-3, 3e-3, 4.5e-3];
W = 6e-3;
c = 3e8;
f = 0:1e8:25e9;
beta_d = zeros(length(f));
b = 1;

Ee_W = ((Er+1)/2) + (((Er-1)/2)*(1/(sqrt(1+((12*d)/W)))));
if W/d <= 1
    Z0_W = (60/sqrt(Ee_W)) * log(((8*d)/W) + (W/(4*d)));
else
    Z0_W = (120*pi)/(sqrt(Ee_W)*(W/d + 1.393 + 0.667 * log((W/d) + 1.444)));
end

for j = Ws
Ee_Ws = ((Er+1)/2) + (((Er-1)/2)*(1/(sqrt(1+((12*d)/j)))));
if j/d <= 1
    Z0_Ws = (60/sqrt(Ee_Ws)) * log(((8*d)/j) + (j/(4*d)));
else
    Z0_Ws = (120*pi)/(sqrt(Ee_Ws)*(j/d + 1.393 + 0.667 * log((j/d) + 1.444)));
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
%title("k-beta dijagram mikrostrip linije sa promenom ws")
xlabel("beta*d [rad/m]")
xlim([0 4])
ylim([0 5e9])
ylabel("f [Hz]")
legend('w_s (numerička) = 1.5 mm', 'w_s (numerička) = 3 mm', 'w_s (numerička) = 4.5 mm')

data3 = readtable('22 3 6.txt');
T31 = data3{:,1}; 
T32 = data3{:,2};

data2 = readtable('22 1_5 6.txt');
T21 = data2{:,1}; 
T22 = data2{:,2};


data4 = readtable('22 4_5 6.txt');
T41 = data4{:,1}; 
T42 = data4{:,2};

plot (T31/58,T42*1e9,'*', 'Color','r', 'DisplayName','w_s (analitička) = 1.5 mm');
plot (T31/58,T22*1e9,'O', 'Color','g', 'DisplayName','w_s (analitička) = 3 mm');
plot (T31/58,T32*1e9,'x', 'Color','b', 'DisplayName','w_s (analitička) = 4.5 mm');
hold off;