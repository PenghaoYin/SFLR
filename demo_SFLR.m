load('gaofen2.mat');
rng("default");

I_lrms = ms/2047;
I_pan = pan/2047;
Ref_I_gt = gt/2047;
sensor = 'none';
ratio = 4;

paras = parasetting(I_lrms,I_pan,sensor,ratio);

fprintf("EXP:\n")
indexes_eval(Ref_I_gt,interp23tap(I_lrms,paras.ratio),paras.ratio,'print');

fprintf("Proposed:\n")
I_fused = SFLR(I_lrms,I_pan,paras);
indexes_eval(Ref_I_gt,I_fused,paras.ratio,'print');

I_AWLP = AWLP(interp23tap(I_lrms,paras.ratio),I_pan,paras.ratio);
fprintf("AWLP:\n")
indexes_eval(Ref_I_gt,I_AWLP,paras.ratio,'print');

subplot(1,3,1);
myshowRGB(I_fused);
title('Test');
subplot(1,3,2);
myshowRGB(I_AWLP);
title('AWLP');
subplot(1,3,3);
myshowRGB(Ref_I_gt);
title("GT");