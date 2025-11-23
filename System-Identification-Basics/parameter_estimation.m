clear;
clc;

%% Load Data
data_fo = load('data_first_order.mat');  % Load the data  
data_so = load('data_second_order.mat');  % Load the data  

% Extract iddata objects and time vectors
y1 = data_fo.data;  % Assuming y1 is the iddata object for first-order system
t1 = data_fo.t;     % Time vector

y2 = data_so.data;  % Assuming y2 is the iddata object for second-order system
t2 = data_so.t;     % Time vector

%% First Order System
% Use the first impulse response for identification (first 96 data points)
i_y1 = y1.OutputData(1:96);  
i_u1 = y1.InputData(1:96);

% Create iddata object for identification data
data_id_fo = iddata(i_y1, i_u1, y1.Ts);

% Estimate transfer function for first-order system
np_fo = 1;                         % Number of poles  
nz_fo = 0;                         % Number of zeros
mtf_fo = tfest(data_id_fo, np_fo, nz_fo);  % Create Transfer function

% Display transfer function
disp('First-Order System Transfer Function:');
mtf_fo

% Plot comparison for identification data
figure;
compare(data_id_fo, mtf_fo);

% Use the next segments for validation
val_y1 = y1.OutputData(97:end);  % Use second and third impulse responses for validation
val_u1 = y1.InputData(97:end);

% Create iddata object for validation data
data_val_fo = iddata(val_y1, val_u1, y1.Ts);

% Plot comparison for entire data
figure;
compare(data_val_fo, mtf_fo);

% Plot original data
figure;
idplot(y1);

% Calculate gain and time constant
num_fo = mtf_fo.Numerator;
den_fo = mtf_fo.Denominator(2); % The first element of the Denominator is 1, so use the second element
K_fo = num_fo / den_fo;
T_fo = 1 / den_fo;
fprintf('First-Order System Gain: K = %.3f\n', K_fo);
fprintf('First-Order System Time Constant: T = %.3f\n', T_fo);

%% Validation of First Order Model
y0_fo = y1.OutputData(96); % Initial condition

% Create state-space model for first-order system
A_fo = -1/T_fo;
B_fo = K_fo/T_fo;
C_fo = 1;
D_fo = 0;
sys_fo_ss = ss(A_fo, B_fo, C_fo, D_fo);

% Simulate the system response
time_vector_fo = t1(97:end) - t1(97);  % Ensure the time vector matches the input data length
[y_sim_fo, ~] = lsim(sys_fo_ss, val_u1, time_vector_fo, y0_fo);

% Plot validation results
figure;
plot(t1(97:end), val_y1, 'b', t1(97:end), y_sim_fo, 'r--');
title('First-Order System Validation');
legend('Actual Output', 'Simulated Output');
xlabel('Time (s)');
ylabel('Response');

% Compute Mean Squared Error (MSE)
MSE_fo = mean((val_y1 - y_sim_fo).^2);
fprintf('First-Order System MSE: %.5f\n', MSE_fo);

%% Second Order System
% Use the first impulse response for identification (first 96 data points)
i_y2 = y2.OutputData(1:96);  
i_u2 = y2.InputData(1:96);

% Create iddata object for identification data
data_id_so = iddata(i_y2, i_u2, y2.Ts);

% Estimate transfer function for second-order system
np_so = 2;                       % Number of poles  
nz_so = 0;                       % Number of zeros
mtf_so = tfest(data_id_so, np_so, nz_so);  % Create Transfer function

% Display transfer function
disp('Second-Order System Transfer Function:');
mtf_so

% Plot comparison for identification data
figure;
compare(data_id_so, mtf_so);

% Use the next segments for validation
val_y2 = y2.OutputData(97:end);  % Use second and third impulse responses for validation
val_u2 = y2.InputData(97:end);

% Create iddata object for validation data
data_val_so = iddata(val_y2, val_u2, y2.Ts);

% Plot comparison for entire data
figure;
compare(data_val_so, mtf_so);

% Plot original data for second-order system
figure;
idplot(y2);

% Calculate natural frequency and damping ratio
wn2_so = mtf_so.Denominator(3);
wn_so = sqrt(wn2_so);
K_so = mtf_so.Numerator / wn2_so;
zeta_so = mtf_so.Denominator(2) / (2 * wn_so);
fprintf('Second-Order System Natural Frequency: wn = %.3f\n', wn_so);
fprintf('Second-Order System Gain: K = %.3f\n', K_so);
fprintf('Second-Order System Damping Ratio: zeta = %.3f\n', zeta_so);

%% Validation of Second Order Model
y0_so = [y2.OutputData(96); 0]; % Initial condition

% Create state-space model for second-order system
A_so = [0 1; -wn_so^2 -2*zeta_so*wn_so];
B_so = [0; K_so*wn_so^2];
C_so = [1 0];
D_so = 0;
sys_so_ss = ss(A_so, B_so, C_so, D_so);

% Simulate the system response
time_vector_so = t2(97:end) - t2(97);  % Ensure the time vector matches the input data length
[y_sim_so, ~] = lsim(sys_so_ss, val_u2, time_vector_so, y0_so);

% Plot validation results
figure;
plot(t2(97:end), val_y2, 'b', t2(97:end), y_sim_so, 'r--');
title('Second-Order System Validation');
legend('Actual Output', 'Simulated Output');
xlabel('Time (s)');
ylabel('Response');

% Compute Mean Squared Error (MSE)
MSE_so = mean((val_y2 - y_sim_so).^2);
fprintf('Second-Order System MSE: %.5f\n', MSE_so);

% Damping ratio comparison using logarithmic decrement method
[~, peak_idx] = findpeaks(i_y2);
delta = log(i_y2(peak_idx(1))/i_y2(peak_idx(2)));
zeta_log_dec = delta / sqrt(4*pi^2 + delta^2);
fprintf('Damping Ratio (Logarithmic Decrement): %.3f\n', zeta_log_dec);
fprintf('Damping Ratio (Transfer Function): %.3f\n', zeta_so);

% Compare the damping ratios and comment on the differences
if abs(zeta_so - zeta_log_dec) > 0.01
    fprintf('The damping ratios obtained by the two methods are significantly different. Further investigation is needed.\n');
else
    fprintf('The damping ratios obtained by the two methods are similar.\n');
end

% End of script
