%Poređenje CST i Matlaba za promenu P

hold on;
figure(1);
p = [18e-3, 22e-3, 26e-3];               % perioda jedinične ćelije
Er = 9.8;
d = 1.27e-3;             % visina dielektrične podloge
Ws = 3e-3;
W = 6e-3;
c = 3e8;
f = 0:1e8:25e9;
beta_d = zeros(length(f));
b = 1;

for j = p
    l = j/2;
Ee_W = ((Er+1)/2) + (((Er-1)/2)*(1/(sqrt(1+((12*d)/W)))));
if W/d <= 1
    Z0_W = (60/sqrt(Ee_W)) * log(((8*d)/W) + (W/(4*d)));
else
    Z0_W = (120*pi)/(sqrt(Ee_W)*(W/d + 1.393 + 0.667 * log((W/d) + 1.444)));
end

Ee_Ws = ((Er+1)/2) + (((Er-1)/2)*(1/(sqrt(1+((12*d)/Ws)))));
if Ws/d <= 1
    Z0_Ws = (60/sqrt(Ee_Ws)) * log(((8*d)/Ws) + (Ws/(4*d)));
else
    Z0_Ws = (120*pi)/(sqrt(Ee_Ws)*(Ws/d + 1.393 + 0.667 * log((Ws/d) + 1.444)));
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
%title("k-beta dijagram mikrostrip linije sa promenom p")
xlabel("beta*d [rad/m]")
ylim([0 5e9])
ylabel("f [Hz]")
legend ('p (numerička) = 26 mm', 'p (numerička) = 22 mm', 'p (numerička) = 18 mm', 'Location', 'southeast')

data3 = readtable('22 3 6.txt');
T31 = data3{:,1}; 
T32 = data3{:,2};

data1 = readtable('18 3 6.txt');
T11 = data1{:,1}; 
T12 = data1{:,2};


data5 = readtable('26 3 6.txt');
T51 = data5{:,1}; 
T52 = data5{:,2};
plot (T31/58,T52*1e9, '*', 'Color', 'r', 'DisplayName','p (analitička) = 26 mm');

plot (T31/58,T12*1e9,'O', 'Color','g', 'DisplayName','p (analitička) = 22 mm');
plot (T31/58,T32*1e9,'x', 'Color','b', 'DisplayName','p (analitička) = 18 mm');
hold off;