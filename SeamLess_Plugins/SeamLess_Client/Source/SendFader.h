/*
  ==============================================================================

    SendFader.h
    Created: 31 Mar 2021 10:34:35am
    Author:  anwaldt

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>
#include "PluginProcessor.h"

//==============================================================================
/*
*/
class SendFader  : public juce::Slider
{
public:
    SendFader(SeamLess_ClientAudioProcessor& p, juce::AudioProcessorValueTreeState& apvts, juce::String s);
    ~SendFader() override;

    void paint (juce::Graphics&) override;
    void resized() override;

    void setText(juce::String s);

private:

    juce::Label sendNameLabel;

    juce::Slider slider;
    juce::AudioProcessorValueTreeState::SliderAttachment sliderAttachment;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (SendFader)
};
