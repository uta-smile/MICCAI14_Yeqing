clear all;close all;
load oriSeq1
load oriSeq2
load oriSeq3
load Result1
load Result2
Result2 = Result;
load Result3
Result3 = Result;

err1 = oriSeq1-Result1;

n = size(Result2,1);
ss= oriSeq2(end-n+1:end,:);
err2 = oriSeq2(end-n+1:end,:)-Result2;

n = size(Result3,1);
err3 = oriSeq3(end-n+1:end,:)-Result3;

err1 = err1.^2;
err1 = sqrt(sum(err1,2));
err2 = err2.^2;
err2 = sqrt(sum(err2,2));
err3 = err3.^2;
err3 = sqrt(sum(err3,2));

k=0;
for th=15:5:40
    k=k+1;
    index=find(err2<=th);
    rate(k)=length(index)/length(err2);
end
rate

figure;hold on;
plot(err1,'r');
plot(err2,'g');
plot(err3,'b');

axis([0 600 0 50]);