
fs1=22050;          % pick sampling rate supported by sound card, 
                    % typically 8 kHz, 11.025 kHz, 22.05 kHz, 44.1 kHz, 48 kHz, 96 kHz
nBits=16;           % bits per sample for quantization
nChannels=2;        % choose 1 for mono, 2 for stereo

recObj = audiorecorder(fs1,nBits,nChannels);       % initiates audio recording 
RecordingTime = 3;                        % sampling Frequency (seconds)

cd('/Volumes/Macintosh HD/Documents-HD/TTU/Year 4/Fall semester/Project Lab III/Main project/Matlab') %selects the main Directory 
TopFolder = cd('../Matlab');    % variable used to return to the main directory 

cd ('Voice recorder')
FF = cd();

% [Phrase1,Phrase2,Phrase3,PhraseFolder] = VoiceRecorder(fs1,nBits,nChannels,RecordingTime,TopFolder,FF);
% cd(FF)
% [NoiseData] = NoiseRecorder(fs1,nBits,nChannels,RecordingTime,TopFolder,FF);
% cd(FF)
% [freq_Noise,tsN] = FreqTransform(NoiseData,fs1);
    
nd = 0:1/fs1:3;



for i = 1:1
    
    
    if i == 1
        Phrase = Phrase1;
    elseif i == 2
        Phrase = Phrase2;
    elseif i == 3
        Phrase = Phrase3;
    end
    
    cd(FF)
    [time_PhraseData1,time_PhraseData2,time_PhraseData3,time_PhraseData4] = VoiceReader(Phrase,TopFolder,FF,PhraseFolder);

%     cd(FF)
%     [ceps_PhraseData1] = MelCepstrum(time_PhraseData1);
%     cd(FF)
%     [ceps_PhraseData2] = MelCepstrum(time_PhraseData2);
%     cd(FF)
%     [ceps_PhraseData3] = MelCepstrum(time_PhraseData3);
%     cd(FF)
%     [ceps_PhraseData4] = MelCepstrum(time_PhraseData4);    
%     
%     nd = nd(1:length(ceps_PhraseData1));

      [c1,tc1]=melcepst(time_PhraseData1,fs1);
      [c2,tc2]=melcepst(time_PhraseData2,fs1);
      [c3,tc3]=melcepst(time_PhraseData3,fs1);
      [c4,tc4]=melcepst(time_PhraseData4,fs1);
      [cNoise,tcNoise]=melcepst(NoiseData,fs1);
      
%       c1 = c1(1,:);
%       c2 = c2(1,:);
%       c3 = c3(1,:);
%       c4 = c4(1,:);
%       cNoise = cNoise(1,:);
      
      cd(FF)
      clean_c1 = RemoveNoise(c1,cNoise,fs1);
      clean_c2 = RemoveNoise(c2,cNoise,fs1);
      clean_c3 = RemoveNoise(c3,cNoise,fs1);
      clean_c4 = RemoveNoise(c4,cNoise,fs1);
      
      [pk1,loc1] = findpeaks(clean_c1);
      [pk2,loc2] = findpeaks(clean_c2);
      [pk3,loc3] = findpeaks(clean_c3);
      [pk4,loc4] = findpeaks(clean_c4);
      
%     cd(FF)
%     [temp_freq_PhraseData1,ts1] = FreqTransform(time_PhraseData1,fs1);
%     cd(FF)
%     [temp_freq_PhraseData2,ts2] = FreqTransform(time_PhraseData2,fs1);
%     cd(FF)
%     [temp_freq_PhraseData3,ts3] = FreqTransform(time_PhraseData3,fs1);
%     cd(FF)
%     [temp_freq_PhraseData4,ts4] = FreqTransform(time_PhraseData4,fs1);
%     
%     freq_PhraseData1 = real(temp_freq_PhraseData1');
%     freq_PhraseData2 = real(temp_freq_PhraseData2');
%     freq_PhraseData3 = real(temp_freq_PhraseData3');
%     freq_PhraseData4 = real(temp_freq_PhraseData4');
% %     
%     freq_PhraseData1 = freq_PhraseData1(1,:);
%     freq_PhraseData2 = freq_PhraseData2(1,:);
%     freq_PhraseData3 = freq_PhraseData3(1,:);
%     freq_PhraseData4 = freq_PhraseData4(1,:);
      
% %     
%     [temp_CleanedData1] = RemoveNoiseSimp(freq_PhraseData1,freq_Noise);
%     [temp_CleanedData2] = RemoveNoiseSimp(freq_PhraseData2,freq_Noise);
%     [temp_CleanedData3] = RemoveNoiseSimp(freq_PhraseData3,freq_Noise);
%     [temp_CleanedData4] = RemoveNoiseSimp(freq_PhraseData4,freq_Noise);
    
%     [CleanedData1,ts01] = RemoveFree(temp_CleanedData1,ts1);
%     [CleanedData2,ts02] = RemoveFree(temp_CleanedData2,ts2);
%     [CleanedData3,ts03] = RemoveFree(temp_CleanedData3,ts3);
%     [CleanedData4,ts04] = RemoveFree(temp_CleanedData4,ts4);
    
    
%     cd(FF)
%     [CleanSig1] = RemoveNoise(freq_PhraseData1,TopFolder,NoiseData,fs1);
%     cd(FF)
%     [CleanSig2] = RemoveNoise(freq_PhraseData2,TopFolder,NoiseData,fs1);
%     cd(FF)
%     [CleanSig3] = RemoveNoise(freq_PhraseData3,TopFolder,NoiseData,fs1);
%     cd(FF)
%     [CleanSig4] = RemoveNoise(freq_PhraseData4,TopFolder,NoiseData,fs1);
%     
%     cd(FF)
%     [Avg_Sig] = highPoints(freq_PhraseData1,freq_PhraseData2,freq_PhraseData3,freq_PhraseData4);
%     
%     if i == 1
%         CleanedPhraseTemp1 = Avg_Sig;
%     elseif i == 2
%         CleanedPhraseTemp2 = Avg_Sig;
%     elseif i == 3
%         CleanedPhraseTemp3 = Avg_Sig;
%     end
end
    
%     ax1 = subplot(4,1,1); % top subplot
%     plot(ax1,ts01,CleanedData1)
%     title(ax1,'Top Subplot')
%     
% 
%     ax2 = subplot(4,1,2); % bottom subplot
%     plot(ax2,ts02,CleanedData2)
%     title(ax2,'Mid Top Subplot')
%     
% 
%     ax3 = subplot(4,1,3); % top subplot
%     plot(ax3,ts03,CleanedData3)
%     title(ax3,'Mid Bot Subplot')
%    
% 
%     ax4 = subplot(4,1,4); % bottom subplot
%     plot(ax4,ts04,CleanedData4)
%     title(ax4,'Bottom Subplot')
    
%     ax1 = subplot(4,1,1); % top subplot
%     plot(ax1,ts1,freq_PhraseData1)
%     title(ax1,'Top Subplot')
%     
% 
%     ax2 = subplot(4,1,2); % bottom subplot
%     plot(ax2,ts2,freq_PhraseData2)
%     title(ax2,'Mid Top Subplot')
%     
% 
%     ax3 = subplot(4,1,3); % top subplot
%     plot(ax3,ts3,freq_PhraseData3)
%     title(ax3,'Mid Bot Subplot')
%    
% 
%     ax4 = subplot(4,1,4); % bottom subplot
%     plot(ax4,ts4,freq_PhraseData4)
%     title(ax4,'Bottom Subplot')

%     
%     ax1 = subplot(4,1,1); % top subplot
%     plot(ax1,ts1,temp_CleanedData1)
%     title(ax1,'Top Subplot')
%     
% 
%     ax2 = subplot(4,1,2); % bottom subplot
%     plot(ax2,ts2,temp_CleanedData2)
%     title(ax2,'Mid Top Subplot')
%     
% 
%     ax3 = subplot(4,1,3); % top subplot
%     plot(ax3,ts3,temp_CleanedData3)
%     title(ax3,'Mid Bot Subplot')
%    
% 
%     ax4 = subplot(4,1,4); % bottom subplot
%     plot(ax4,ts4,temp_CleanedData4)
%     title(ax4,'Bottom Subplot')
    
%     
%         ax1 = subplot(4,1,1); % top subplot
%     plot(ax1,nd,ceps_PhraseData1)
%     title(ax1,'Top Subplot')
%     
% 
%     ax2 = subplot(4,1,2); % bottom subplot
%     plot(ax2,nd,ceps_PhraseData2)
%     title(ax2,'Mid Top Subplot')
%     
% 
%     ax3 = subplot(4,1,3); % top subplot
%     plot(ax3,nd,ceps_PhraseData3)
%     title(ax3,'Mid Bot Subplot')
%    
% 
%     ax4 = subplot(4,1,4); % bottom subplot
%     plot(ax4,nd,ceps_PhraseData4)
%     title(ax4,'Bottom Subplot')
    
%     
%     ax1 = subplot(4,1,1); % top subplot
%     plot(ax1,tc1,clean_c1)
%     title(ax1,'Top Subplot')
%     
% 
%     ax2 = subplot(4,1,2); % bottom subplot
%     plot(ax2,tc2,clean_c2)
%     title(ax2,'Mid Top Subplot')
%     
% 
%     ax3 = subplot(4,1,3); % top subplot
%     plot(ax3,tc3,clean_c3)
%     title(ax3,'Mid Bot Subplot')
%    
% 
%     ax4 = subplot(4,1,4); % bottom subplot
%     plot(ax4,tc4,clean_c4)
%     title(ax4,'Bottom Subplot')
% 
        ax1 = subplot(4,1,1); % top subplot
    plot(ax1,loc1,pk1)
    title(ax1,'Top Subplot')
    

    ax2 = subplot(4,1,2); % bottom subplot
    plot(ax2,loc2,pk2)
    title(ax2,'Mid Top Subplot')
    

    ax3 = subplot(4,1,3); % top subplot
    plot(ax3,loc3,pk3)
    title(ax3,'Mid Bot Subplot')
   

    ax4 = subplot(4,1,4); % bottom subplot
    plot(ax4,loc4,pk4)
    title(ax4,'Bottom Subplot')

