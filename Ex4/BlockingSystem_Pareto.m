function [BS,CI] = BlockingSystem_Pareto(n,s,l,c,ite)
% Blocking System Simulated
% Inputs
    % n = service units
    % s = mean service time
    % l = mean time between customers
    % c = customers
    % ite = iterations
% Outputs
    % BS = probability of blocking
    % CI = 95% confidence intervals

k = 1.05;
for j = 1:ite
    ns = zeros(1,n); % Servers
    tc_t = 0;        % Total time between customers
    cs = 0;          % Customers served
    cb = 0;          % Customers blocked
    for i = 1:c
        [min_ns_t,min_ns_idx] = min(ns); % Minimum time for server is ready
        tc = exprnd(l);      % Time between customers
        ts = gprnd(k,s,s/k); % Service time
        if tc_t >= min_ns_t
            ns(min_ns_idx) = tc_t+ts;
            cs = cs+1;   % Customers served
        else
            cb = cb+1;   % Customers blocked
        end
        tc_t = tc_t+tc;  % Total time between customers
    end
    cb_vec(j) = cb;      % Customers blocked of every iteration
end
pb = cb_vec/c; % Probability of blocking of every iteration
BS = mean(pb); % Mean of blocked customers
CI = conf(pb); % 95% confidence intervals