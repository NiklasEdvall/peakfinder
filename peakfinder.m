%Create random signal vector, i.e. n = 40 random values between 0 and 10
length = 100;

a = round(rand(1,length).*10, 0);

%Create some random responses
place1 = round((length-1).*rand(1,1) + 1, 0);
place2 = round((length-1).*rand(1,1) + 1, 0);
place3 = round((length-1).*rand(1,1) + 1, 0);

maxresponse = 25;

response1 = round((maxresponse-11).*rand(1,1) + 11, 1);
response2 = round((maxresponse-11).*rand(1,1) + 11, 1);
response3 = round((maxresponse-11).*rand(1,1) + 11, 1);

%Inject responses in signal vector
a(place1) = response1;
a(place2) = response2;
a(place3) = response3;

%How many peaks to look for
n_peaks = 3;

%Create a figure, plot original vector and overlay peaks
figure; hold on;
plot(a, 'Color', [0 0 1]);
for i = 1:n_peaks;
    
    %findpeaks
    [ps, pind] = findpeaks(a);
    
    %sort peaks for descending amplitude
    [M, I] = sort(ps, 'descend');
    
    %find all local minimum in vector
    locmin = islocalmin(a);
    
    %find local minimum on both sides of peak i
    locmin_on = find(flip(locmin(1:pind(I(i)))), 1, 'first') - 1;
    locmin_off = find(locmin(pind(I(i)):end), 1, 'first') - 1;
    
    %get the part of the original vector that is peak i
    peak_ind = (pind(I(i))-locmin_on):(pind(I(i))+locmin_off);
    peak_val = a(peak_ind);
    
    %plot peak i
    plot(peak_ind, peak_val, 'Color', [1 0 0], 'LineWidth', 1.5)

end