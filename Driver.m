%% Assignment 3
close all;

nRows = 30;
nCols = 30;
nSims = 100;
nChains = 3;
nThin = 10;
nBurnin = 2000;
nIterations = 3000;
J = -1;

Ts = linspace(0.1, 5, nSims);
EResults = zeros(1, nSims);
MResults = zeros(1, nSims);

for i = 1:nSims
    lat = Lattice(nRows,nCols, J, Ts(i), false);
    MC = MCMC( lat, 1, nIterations, nThin, nBurnin);
    MC.runChains();
    EResults(i) = MC.E;
    MResults(i) = MC.M;
end

% Plot the results 
plot(Ts, EResults, 'kx');
xlabel("T");
ylabel("<E>");
title("System Energy");
legend("Simulation");

figure;
plot(Ts, MResults./(nRows*nCols), 'kx');
f = @(x) ( 1 - 1/(sinh(2/x))^2)^(1/8);
hold on;
fplot(f, [0 5]);
T_c = 1/(log(1+sqrt(2)));
xline(T_c);
title("Magentization per Spin");
xlabel("T");
ylabel("<|M|>");
legend("Simulation", "Osager-Yang Solution", "T_c");