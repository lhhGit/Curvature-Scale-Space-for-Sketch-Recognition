%产生传统CSS匹配方法出现的反例

p1 = load('SR_testData\\pavilion_1.txt');

figure;
plot(p1(:,1),p1(:,2));
axis off;


p2 = load('SR_testData\\star.txt');

figure;
plot(p2(:,1),p2(:,2));
axis off;


p3 = load('SR_testData\\pavilion_trem_1.txt');

figure;
plot(p3(:,1),p3(:,2));
axis off;