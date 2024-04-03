function paras = parasetting(lrms,pan,sensor,ratio)

paras = {};
switch sensor
    case 'none'
        paras.alpha = 6.8e+2; paras.beta = 6.7e+3;
        paras.gamma1 = 1.8e-4; paras.gamma2 = 5.0e-5; paras.gamma3 = 7.5e-4; paras.gamma4 = 5.0e-2;
    case 'WV3'
        paras.alpha = 4.3e+5; paras.beta = 1.2e+0;
        paras.gamma1 = 3.6e-4; paras.gamma2 = 1.0e-8; paras.gamma3 = 5.1e+1; paras.gamma4 = 1.2e-8;
    otherwise
        paras.alpha = 6.8e+2; paras.beta = 6.7e+3;
        paras.gamma1 = 1.8e-4; paras.gamma2 = 5.0e-5; paras.gamma3 = 7.5e-4; paras.gamma4 = 5.0e-2;
end

paras.ratio = ratio;
paras.sensor = sensor; 
paras.sz = size(pan);
paras.Nways = [size(pan,1,2),size(lrms,3)];

end

