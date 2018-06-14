function [ value,isterminal,direction ] = eventBoundary( t,y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
value(1) = max( y(1),y(2) )-1;     % Detect SOC=1
isterminal(1) = 1;   % Stop the integration
direction(1) = 1;   % Positive direction only

value(2) = min( y(1),y(2) )-0;     % Detect SOC=0
isterminal(2) = 1;   % Stop the integration
direction(2) = -1;   % Negtive direction only
end

