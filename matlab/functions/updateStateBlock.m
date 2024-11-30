% function file
% Author: Edward J. Xu
% Date: 190619
% ######################################################################################################################


function [nCustomerServe, nCustomerBlock, vecTimeDepart] = updateStateBlock(clockSim, nServer, nCustomerServe, ...
    nCustomerBlock, vecTimeDepart, timeServe)
    nCustomerServe = nCustomerServe + 1;
    % Check the departed customers
    for j = 1:nServer
        if (vecTimeDepart(j) ~= 0) & (vecTimeDepart(j) <= clockSim)  % There is a customer and he/she has already left.
            vecTimeDepart(j) = 0;  % The vacancy is set to 0.
            nCustomerServe = nCustomerServe - 1;
        end
    end
    % Check if there is a block
    if nCustomerServe > nServer
        nCustomerBlock = nCustomerBlock + (nCustomerServe - nServer);
        nCustomerServe = nServer;
    else
        % Select the first server without a customer, assign a customer to it.
        j = 1;
        while vecTimeDepart(j) ~= 0
            j = j + 1;
        end
        vecTimeDepart(j) = clockSim + timeServe;  % Set the service time
    end
end  % function
