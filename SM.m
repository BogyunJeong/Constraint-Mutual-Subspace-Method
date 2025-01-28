clc,clear,close all 
load('Yale_32x32.mat')
training_sampleA =  fea(12:19,:);
training_sampleB =fea(67:74,:);



for i = 20:22
test_sampleA = fea(i,:);
p1 = test_sampleA;
[QA_U,QA_S,QA_V] = svd(training_sampleA, 'econ');
[QB_U,QB_S,QB_V] = svd(training_sampleB, 'econ');

S1 = sum((p1 * QA_V).^2)/(norm(p1)^2);
S2 = sum((p1 * QB_V).^2)/(norm(p1)^2);

classA = 'class = A';
classB = 'class = B';
if     (S1) > (S2)
    disp(classA)
elseif (S2) > (S1)
    disp(classB)
end
end
%
for i = 75:77
test_sampleB = fea(i,:);
p2 = test_sampleB;

SS1 = sum((p2 * QA_V).^2)/(norm(p2)^2);
SS2 = sum(((p2 * QB_V).^2)/(norm(p2)^2));

if     (SS1) > (SS2)
    disp(classA)
elseif (SS2) > (SS1)
     disp(classB)
end
end