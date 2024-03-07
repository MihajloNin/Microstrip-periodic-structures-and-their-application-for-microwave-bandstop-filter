%Vector Network Analzyer - mereni rezultati
hold on;

grid
legend('Location', 'southeast')

data1 = readtable('VNA 2.txt');
T11 = data1{:,1}; 
T12 = data1{:,2};
plot (T11,T12*1e-6, 'Color', '#FFA500', 'DisplayName', 'S_11 (merenja)');

data2 = readtable('VNA 1.txt');
T21 = data2{:,1}; 
T22 = data2{:,2};
plot (T21,T22*1e-6, 'Color', 'b', 'DisplayName', 'S_12 (merenja)');

data3 = readtable('opet.txt');
T31 = data3{:,1}; 
T32 = data3{:,2};
plot (T31*1e9,T32, 'Color', 'r', 'DisplayName', 'S_11 (simulacije)');

data4 = readtable('opet2.txt');
T41 = data4{:,1}; 
T42 = data4{:,2};
plot (T41*1e9,T42, 'Color', 'g', 'DisplayName', 'S_12 (simulacije)');

hold off;
xlabel("f [Hz]");
xlim([1e9 4.5e9])
pbaspect([2 1 1])
ylabel("S parametri [dB]");