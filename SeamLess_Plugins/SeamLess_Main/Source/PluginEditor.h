/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>
#include "PluginProcessor.h"

#include "ConnectionBox.h"
#include "ReverbFaderBox.h"
#include "OutgoingConnectionComponent.h"

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

    SeamLess_MainAudioProcessor& audioProcessor;

    ConnectionBox oscConnectionBox;

    ReverbFaderBox reverbFaderBox;

    OutgoingConnectionComponent connectionComponent;


     void timerCallback();

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (SeamLess_MainAudioProcessorEditor)
};
