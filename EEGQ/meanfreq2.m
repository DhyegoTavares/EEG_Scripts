function spec=meanfreq(fmin,fmax,chanArray,frames,epochs,srate,dados)

nchan = length(chanArray);
data = zeros(nchan,frames,epochs);

for k=1:nchan
    data(k,:)=dados(chanArray(k),:);
end

fftlength = 2^floor(log(frames)/log(2));
[rows,cols] = size(data);
spectra = zeros(rows,epochs*fftlength/2);
f2 = fftlength/2;
dB = 10/log(10);

Hzlimits = [fmin,fmax];

for e=1:epochs
    for r=1:rows,
        [Pxx,freqs2] = pwelch(data(r,(e-1)*frames+1:e*frames), [], [], fftlength, srate);
        %[Pxx,freqs2] = psd(data(r,(e-1)*frames+1:e*frames),fftlength,...,
        %    srate,fftlength,fftlength/4);
        spectra(r,(e-1)*f2+1:e*f2) = Pxx(1:f2)';
    end
end

freqs = freqs2(1:f2);
fsi = find(freqs >= Hzlimits(1) & freqs <= Hzlimits(2));
minf = freqs(fsi(1));
maxf = freqs(fsi(length(fsi)));
nfs = length(fsi);

showspec = zeros(rows,length(fsi)*epochs);
for e = 1:epochs
    showspec(:,(e-1)*nfs+1:e*nfs) = dB*log(spectra(:,(e-1)*f2+fsi));
end

showspec = blockave(showspec,nfs);
if size(showspec,2) >1 
   spec = mean(showspec');
else
    spec = showspec;
end

%plot(spec');
end


