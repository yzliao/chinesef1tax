% 1040nrez.m
% LYZ @ Feb 2nd, 2013
clear all
close all

display('Thank you for using this script');
Y = 'Y';
N = 'N';

%%Part 1

% Test Question
display('Section 1: Identification Questions');
display('Please type Y or N or number for following questions');

% If Chinese
ans1 = input('Are you Chinese citizen or holding PRC-issued passport? :');
if ~strcmp(ans1,'Y')
    display('This script is not for you');
    error('Error');
end

% F1-holder
ans1 = input('Are you holding F1 visa? :');
if ~strcmp(ans1,'Y')
    display('This script does not work for you');
    error('Error');
else
    ans2 = input('Which calendar year is your first time to arrive U.S. for studying? :');
    if 2012 - ans2 > 5,
        display('You are not non resident for tax purpose. Please use Form 1040');
        error('Error');
    end
end

% working status
ans1 = input('Have you worked in calendar year 2012? :');

if strcmp(ans1,'Y')
    ans2 = input('Have you received W2 form from employer? :');
    if ~strcmp(ans2,'Y'),
        display('You need to receive W2 form for filling tax return');
        error('Error');
    end
    ans3 = input('Have you received 1099-misc form from employer? :');
    if ~strcmp(ans3,'N')
        display('You need to use 1040nr, not 1040nr-ez');
        error('Error');
    end
        
elseif strcmp(ans1,'N')
    display('You do not need to fill 1040NR-EZ. You only need to fill 8843.');
    error('Error');
else
    error('Error');
end


% 1042-s test
ans1 = input('Have you filled 8233 at the beginning of 2012? :');
ans2 = input('Have you received fellowship/scholarship during 2012? :');
ans3 = input('Have you been exempted for tax treaty? :');

if strcmp(ans1,'Y') || strcmp(ans2,'Y') || strcmp(ans3,'Y'),
    have1042 = true;
    ans4 = input('Have you received 1042s from your employer? :');
    if strcmp(ans4,'N')
        display('You need to receive 1042s for filling tax form');
        error('Error');
    end
else
    have1042 = false;
end

if strcmp(ans2,'Y')
    havefellow = true;
else
    havefellow = false;
end

if strcmp(ans3,'N')
    ifexempted = false;
else
    ifexempted = true;
end

% singlue or married
ans1 = input('Are you single? :');
if ~strcmp(ans1,'Y')
    display('This script is for single.');
    error('Error');
end

% student loan
ans1 = input('Do you have student loan? :');
if ~strcmp(ans1,'N')
    display('This script is good for you.');
    error('Error');
end

% pass test
display('You pass the tests. You can use this script to calculate your tax return');


%%Part2
display('=======================================');
display('Start to calcuate the tax');

% Line 3
num3 = input('Please enter the amount shown in box 1 of W-2: ');

if ~ifexempted,
    num3 = num3 - 5000;
    if num3 < 0,
        num3 = 0;
    end
end


% Line 4
ans1 = input('Have you received 1099G? :');
if strcmp(ans1,'Y'),
    num4 = input('Please enter the total amount for state and local tax return in 1099G');
else
    num4 = 0;
end

% Line 5
if have1042,
    num5 = input('Please enter the total amount in 1042s( box2 of line 5.): ');
else
    num5 = 0;
end

% Line 6
if havefellow
    num_fellow = input('Please enter the total fellowship or scholarship received during 2012: ');
end

if ifexempted
    if num3 < 5000,
        num6 = num3 + num_fellow;
    else
        num6 = 5000 + num_fellow;
    end
else
    num6 = 5000 + num_fellow;
end

% set fellowship to 0 due to treaty
num5 = 0;


% Line 7
num7 = num3+num4+num5;

% Line 8
num8 = 0;

% Line 9
num9 = 0;

% Line 10
num10 = num7 - num8 - num9;

% Line 11
num11 = input('Please enter the total amount of state and local tax in W2: ');

% Line 12
num12 = num10 - num11;

% Line 13
num13 = 3800;

% Line 14
num14 = num12 - num13;
if num14 < 0,
    num14 = 0;
end

% Line 15
display(['You total taxable income is ',num2str(num14)]);
display('Please go to http://www.irs.gov/pub/irs-pdf/i1040nre.pdf Page 21 to find your tax');
num15 = input('Enter your tax in i1040nre.pdf: ');

% Line 16
num16 = 0;

% Line 17
num17 = num15 + num16;

% Line 18
num18a = input('Enter the federal tax withheld on W2 (box 2): ');
num18b = input('Enter the federal tax withheld on 1042-s (box 9): ');

% Line 19
num19 = 0;

% Line 20
num20 = 0;

% Line 21
num21 = num18a + num18b + num19 + num20;

% Line 22
num22 = num21 - num17; 
if num22 > 0,
    display('You will have tax return this year');
    display(['Return: ', num2str(num22)]);
    hasreturn = true;
elseif num22 ~= 0
    display('You will need to pay more taxes this year');
    display(['Owe: ', num2str(-num22)]);
    hasreturn = false;
end

% Line 23
num23a = num22;

% Line 25
if ~hasreturn
    num25 = -num22;
end

%%part3
% Page 1
fprintf('Line 3 %.2f\n Line 4 %.2f\n Line 5 %.2f\n Line 6 %.2f\n Line 7 %.2f\n',...
    num3,num4,num5,num6,num7);
fprintf('Line 8 %.2f\n Line 9 %.2f\n Line 10 %.2f\n Line 11 %.2f\n Line 12 %.2f\n',...
    num8,num9,num10,num11,num12);
fprintf('Line 13 %.2f\n Line 14 %.2f\n Line 15 %.2f\n Line 16 %.2f\n Line 17 %.2f\n',...
    num13,num14,num15,num16,num17);
fprintf('Line 18a %.2f\n Line 18b %.2f\n Line 19 %.2f\n Line 20 %.2f\n Line 21 %.2f\n',...
    num18a,num18b,num19,num20,num21);

if hasreturn,
    fprintf('Line 22 %.2f\n, Line 23a %.2f\n',...
        num22,num23a);
else
    fprintf('Line 25 %.2f\n', num25);
end

% Page 2
display('A -- China');
display('B -- China');
display('C -- No');
display('D -- No (both)');
display('E -- F1');
display('F -- No (for most people...)');
display('G -- enter the date');
display('H -- you need to calculate it..');
display('I -- please fill it by your own situiation');
display('J1');
display(['China,20(c),12,',num2str(num6-num_fellow)]);
if havefellow,
    display(['China,20(b),12,',num2str(num_fellow)]);
end
display(['J1(e)---',num2str(num6)]);
display('J2 -- No');












    