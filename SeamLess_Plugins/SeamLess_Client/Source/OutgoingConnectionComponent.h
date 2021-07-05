/*
  ==============================================================================

    OutgoingConnectionComponent.h
    Created: 24 Mar 2021 10:31:46pm
    Author:  anwaldt

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>

#include "SeamLess_Client.h"
#include "PluginProcessor.h"

//==============================================================================
/*
*/
class OutgoingConnectionComponent  : public juce::Component, juce::Timer
{
public:
    OutgoingConnectionComponent(SeamLess_ClientAudioProcessor *a);
    ~OutgoingConnectionComponent() override;

    void paint (juce::Graphics&) override;
    void resized() override;

    virtual void timerCallback() override;

private:

    SeamLess_ClientAudioProcessor *audioProcessor;

    juce::Label oscTargetAddressText;
    juce::Label oscTargetPortText;

    juce::ToggleButton sendButton   {"Send OSC"};

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (OutgoingConnectionComponent)
};
