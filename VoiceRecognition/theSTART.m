

fs1=22050;          % pick sampling rate supported by sound card, 
                    % typically 8 kHz, 11.025 kHz, 22.05 kHz, 44.1 kHz, 48 kHz, 96 kHz
nBits=16;           % bits per sample for quantization
nChannels=2;        % choose 1 for mono, 2 for stereo

RecordingTime = 3;                        % sampling Frequency (seconds)

cd('/Volumes/Macintosh HD/Documents-HD/TTU/Year 4/Fall semester/Project Lab III/Main project/Matlab') %selects the main Directory 
TopFolder = cd('../Matlab');    % variable used to return to the main directory 

cd('Phrases')
PhraseFolder = cd();

cd(TopFolder)
cd ('Voice recorder')
FF = cd();


Choose = 0;
% ran = 0;
while Choose == 0
    
    disp('1. Setup Process')
    disp('2. Recognition Process')
    disp('3. Exit...')
    prompt = 'enter mode number value: ';    % User input prompt for first Phrase
    temp = input(prompt);
    
    if temp == 1
        [PhraseFolder] = VoiceRecorder(fs1,nBits,nChannels,RecordingTime,TopFolder,FF);
        ran = 1;
    elseif temp == 2
        if ran == 1
            [compA] = Recog2(TopFolder,FF,fs1,PhraseFolder);
        else
            disp('ERROR: Please run the set up process before Recognition')
        end
    elseif temp == 3
        Choose = 1;
    else
        disp('Uhhh... only choose 1, 2 or 3 lol')
    end
    
    
end