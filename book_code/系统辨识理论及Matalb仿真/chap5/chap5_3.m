clear all;
close all;
w= logspace(-1,1)
H = [ 0.9892 - 0.1073i   0.9870 - 0.1176i   0.9843 - 0.1289i   0.9812 - 0.1412i   0.9773 - 0.1545i   0.9728 - 0.1691i   0.9673 - 0.1848i   0.9608 - 0.2017i   0.9530 - 0.2200i   0.9437 - 0.2396i   0.9328 - 0.2605i   0.9198 - 0.2826i   0.9047 - 0.3058i   0.8869 - 0.3301i   0.8662 - 0.3551i   0.8424 - 0.3805i   0.8150 - 0.4060i   0.7840 - 0.4310i   0.7491 - 0.4549i   0.7103 - 0.4771i   0.6677 - 0.4968i   0.6216 - 0.5133i   0.5725 - 0.5258i   0.5210 - 0.5335i   0.4680 - 0.5361i   0.4144 - 0.5331i   0.3613 - 0.5242i   0.3099 - 0.5098i   0.2613 - 0.4900i   0.2164 - 0.4654i   0.1762 - 0.4370i   0.1413 - 0.4057i   0.1121 - 0.3728i   0.0886 - 0.3393i   0.0706 - 0.3064i   0.0577 - 0.2753i   0.0489 - 0.2466i   0.0436 - 0.2210i   0.0406 - 0.1987i   0.0391 - 0.1796i   0.0383 - 0.1635i   0.0377 - 0.1499i   0.0369 - 0.1385i   0.0356 - 0.1287i   0.0339 - 0.1201i   0.0318 - 0.1123i   0.0293 - 0.1051i   0.0266 - 0.0983i   0.0239 - 0.0919i   0.0212 - 0.0857i];
[num,den] = invfreqs(H,w,3,4);
G=tf(num,den)
