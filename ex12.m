%    COHERENCE
clear all;
close all;
clc;

pkg load signal;

samples = 256;

% load data
x = load("samples.txt");

% abstracting mean value
x = x - mean(x);

% sampling frequency
fs = 256;

% cutoff frequency
fc =4 ;

%filter order
n =10 ;

figure(1);
% filtering using butter
[b,a] = butter(n,fc/(fs/2));
freqz(b,a)
y = filter(b,a,x);

%    PLOT SIGNALS
figure(2);
plot(1:samples,y);
xlabel('SAMPLES');
ylabel('SIGNAL AMPLITUDE');
title('FILTERED  SIGNALS');
axis([0 256 min(min(y)) max(max(y))]);
legend('1', '2', '3');

%  coherence estimations
figure(3);
for i=1:3
  for j=1:3
      [ch, F] = mscohere(y(:,i),y(:,j));
      subplot(3,3, (i-1)*3+j);
      plot(samples*F, ch, 'g', 'LineWidth',3);
      axis([0 samples/2 0 1]);
      xlabel('FREQUENCY (Hz)');
      ylabel('COHERENCE COEFICIENT' );
      title(['FILTERED SIGNAL COHERENCE ESTIMATION ', num2str(i), ' ', num2str(j)]);
      grid on
 end
end

