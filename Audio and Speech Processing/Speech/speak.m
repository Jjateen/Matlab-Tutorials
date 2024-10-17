clc;clear;
UserInput = 'This is a test Message'; % Convert from cell to string.
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
Speak(obj, UserInput);
