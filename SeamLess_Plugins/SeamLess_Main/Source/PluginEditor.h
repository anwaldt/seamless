/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>
#include "PluginProcessor.h"

#include "ReverbFaderBox.h"

//==============================================================================
/**
*/
class SeamLess_MainAudioProcessorEditor  : public juce::AudioProcessorEditor, juce::Timer
{
public:
    SeamLess_MainAudioProcessorEditor (SeamLess_MainAudioProcessor&, juce::AudioProcessorValueTreeState&);
    ~SeamLess_MainAudioProcessorEditor() override;

    //==============================================================================
    void paint (juce::Graphics&) override;
    void resized() override;

private:
    // This reference is provided as a quick way for your editor to
    // access the processor object that created it.
    SeamLess_MainAudioProcessor& audioProcessor;

    ReverbFaderBox reverbFaderBox;

    juce::Label incomingPortLabel;
    juce::Label incomingPortText;


    juce::Label timeLabel;

     void timerCallback();

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (SeamLess_MainAudioProcessorEditor)
};
