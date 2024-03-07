hold on;
%Poređenje CST i Matlaba za parametar S


grid

data1 = readtable('opet.txt');
T11 = data1{:,1}; 
T12 = data1{:,2};
plot (T11,T12);

data2 = readtable('opet2.txt');
T21 = data2{:,1}; 
T22 = data2{:,2};
plot (T21,T22);

hold off;
xlabel("GHz");
ylabel("dB");