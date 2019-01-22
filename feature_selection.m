function [W,FRAC] = feature_selection(x)

for i = linspace(1,size(x,2),20)
[W,FRAC] = pcam(x,i);
clc
disp(i)
end

figure;
plot(FRAC)
xlabel('number of features');
ylabel('Fraction of cumulative variance retained')
grid on
end

