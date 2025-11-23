
% Load the data
data=load('system_data.mat')  % Load the data % assuming the data file is named 'm_yemisci.mat'
id = data.id;
val = data.val;
function [theta, y_sim] = Arx_identification(id, val, na, nb)
    % Extract input-output data from iddata objects
    u_id = id.u;
    y_id = id.y;
    u_val = val.u;
    y_val = val.y;
    
    % Number of samples
    N_id = length(y_id);
    N_val = length(y_val);
    
    % Construct the regression matrix for identification data
    phi_id = zeros(N_id, na + nb);
    for k = 1:N_id
        for i = 1:na
            if k-i > 0
                phi_id(k, i) = y_id(k-i);
            else
                phi_id(k, i) = 0;
            end
        end
        for j = 1:nb
            if k-j > 0
                phi_id(k, na+j) = u_id(k-j);
            else
                phi_id(k, na+j) = 0;
            end
        end
    end
    
    % Perform linear regression to find the parameters
    theta = phi_id \ y_id;
    
    % Simulate the model on validation data
    y_sim = zeros(N_val, 1);
    for k = 1:N_val
        for i = 1:na
            if k-i > 0
                y_sim(k) = y_sim(k) + theta(i) * y_sim(k-i);
            else
                y_sim(k) = y_sim(k) + theta(i) * 0;
            end
        end
        for j = 1:nb
            if k-j > 0
                y_sim(k) = y_sim(k) + theta(na+j) * u_val(k-j);
            else
                y_sim(k) = y_sim(k) + theta(na+j) * 0;
            end
        end
    end
end

function plot_data(id, val)
    figure;
    subplot(2,1,1);
    plot(id.y);
    title('Identification Data Output');
    xlabel('Time');
    ylabel('Output y');

    subplot(2,1,2);
    plot(id.u);
    title('Identification Data Input');
    xlabel('Time');
    ylabel('Input u');
    
    figure;
    subplot(2,1,1);
    plot(val.y);
    title('Validation Data Output');
    xlabel('Time');
    ylabel('Output y');

    subplot(2,1,2);
    plot(val.u);
    title('Validation Data Input');
    xlabel('Time');
    ylabel('Input u');
end

% Main script
% Load the identification and validation data
load('system_data.mat'); % Assume data is stored in data.mat

% Plot the identification and validation data
plot_data(id, val);

% Guess the orders na and nb from the step response
na = 2; % Example guess
nb = 2; % Example guess

% Identify the model using custom ARX code
[theta, y_sim] = Arx_identification(id, val, na, nb);

% Identify the model using MATLAB's arx function
sys_arx = arx(id, [na nb 1]);

% Simulate the MATLAB ARX model on validation data
y_sim_arx = sim(sys_arx, val.u);

% Plot the results
figure;
plot(val.y, 'b');
hold on;
plot(y_sim, 'r--');
plot(y_sim_arx, 'g-.');
legend('True Output', 'Custom ARX Output', 'MATLAB ARX Output');
title('Validation Data and Model Outputs');
xlabel('Time');
ylabel('Output y');
hold off;

% Find the best structure using struc functions
nn = struc(1:5, 1:5, 1); % Test a range of model orders
V = arxstruc(id, val, nn);
[order, Vmod] = selstruc(V, 0); % Select the best order structure

% Identify the best model using MATLAB's arx function
sys_best = arx(id, order);

% Simulate the best MATLAB ARX model on validation data
y_sim_best = sim(sys_best, val.u);

% Identify the best model using custom ARX code
[theta_best, y_sim_best_custom] = Arx_identification(id, val, order(1), order(2));

% Plot the results
figure;
plot(val.y, 'b');
hold on;
plot(y_sim_best_custom, 'r--');
plot(y_sim_best, 'g-.');
legend('True Output', 'Best Custom ARX Output', 'Best MATLAB ARX Output');
title('Validation Data and Best Model Outputs');
xlabel('Time');
ylabel('Output y');
hold off;

% Use the compare function to get a detailed comparison
figure;
compare(val, sys_best, iddata(y_sim_best_custom, val.u, val.Ts));
legend('True Output', 'Best MATLAB ARX Output', 'Best Custom ARX Output');
