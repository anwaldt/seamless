/*
  ==============================================================================

    SendFaderBox.h
    Created: 31 Mar 2021 12:13:37am
    Author:  anwaldt

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>

#include "SeamLess_Client.h"
#include "SendFader.h"
#include "PluginProcessor.h"


//==============================================================================
/*
*/
class SendFaderBox  : public juce::Component, juce::Slider::Listener
{
public:

    SendFaderBox(SeamLess_ClientAudioProcessor &p, juce::AudioProcessorValueTreeState &apvts);
    ~SendFaderBox() override;

    void paint (juce::Graphics&) override;
    void resized() override;

    /// \brief sliderValueChanged
    /// \param slider
    /// A slider listener for all send gain sliders.
    void sliderValueChanged (juce::Slider* slider);

private:

    SeamLess_ClientAudioProcessor& audioProcessor;
    juce::AudioProcessorValueTreeState& treeState;

    SendFader sendFaderWFS;
    SendFader sendFaderHOA;
    SendFader sendFaderREV;
    SendFader sendFaderLFE;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (SendFaderBox)
};
