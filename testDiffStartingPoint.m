%�۲첻ͬ�Ļ�����ʼ���CSSͼ������Ӱ��
P = load('star_closed.itf');

len = length(P);

Q1 = [P(:,1) + 100, P(:,2) + 200]; 

Q2 = [P(:,1) - 200, P(:,2) - 100]; 

figure;
plot(P(:,1),P(:,2));
hold on;
plot(P(1,1),P(1,2),'r.');
axis off;

figure;
plot(Q1(:,1),Q1(:,2));
hold on;
plot(Q1(1,1),Q1(1,2),'r.');
axis off;

figure;
plot(Q2(:,1),Q2(:,2));
hold on;
plot(Q2(1,1),Q2(1,2),'r.');
axis off;
