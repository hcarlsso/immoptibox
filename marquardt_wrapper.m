function [x_hat, info] = marquardt_wrapper(fun, x0, opts, varargin)
%MARQUARDT_WRAPPER Summary of this function goes here
%   Detailed explanation goes here

[X_trace, info_m, perf_m] = marquardt(fun, x0, opts, varargin{:});

x_hat = X_trace(:,end);
info = struct('cost_trace', perf_m.f,...
    'x_trace', X_trace, ...
    'g_trace', perf_m.ng, ...
    'mu_trace', perf_m.mu, ...
    'end_f', info_m(1), ...
    'end_g_norm', info_m(2), ...
    'end_dx_norm', info_m(3), ...
    'iter_index', 0:info_m(5), ...
    'n_iterations', info_m(5),...
    'n_f_evaluations', info_m(6),...
    'stop_condition_numeric', info_m(7));

switch info_m(7)
    case 1
        s = 'Stopped by small gradient';
    case 2
        s = 'Stopped by small x-step';
    case 3
        s = 'No. of function evaluations exceeded';
    case -1
        s = 'x is not a real valued vector';
    case -2
        s = 'r is not a real valued column vector';
    case -3
        s = 'J is not a real valued matrix';
    case -4
        s = 'Dimension mismatch in x, r, J';
    case -5
        s = 'Overflow during computation';
    otherwise
        s = 'Unknown error';
end

info.stop_condition = s;

end

