/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#pragma once

#include <JuceHeader.h>
#include <JuceHeader.h>
#include "PluginProcessor.h"
#include "TopView.h"
#include "OutgoingConnectionComponent.h"
#include "SendFaderBox.h"
#include "SourceSettingsComponent.h"

//==============================================================================

/**
*/
class SeamLess_ClientAudioProcessorEditor  : public juce::AudioProcessorEditor,
        public juce::Slider::Listener
{
public:
    SeamLess_ClientAudioProcessorEditor (SeamLess_ClientAudioProcessor&, juce::AudioProcessorValueTreeState&);
    ~SeamLess_ClientAudioProcessorEditor() override;

    //==============================================================================
    void paint (juce::Graphics&);
    void resized();

    // static void setOscTargetAddressText(SeamLess_ClientAudioProcessorEditor *p, juce::String a);

private:

    SeamLess_ClientAudioProcessor& audioProcessor;
    juce::AudioProcessorValueTreeState& treeState;

    SendFaderBox sendBox;

    OutgoingConnectionComponent connectionComponent;

    SourceSettingsComponent settingComponent;

    TopView topView;

    //    juce::Slider xSlider;
    //    juce::Slider ySlider;

    juce::Slider zSlider;

    juce::Label zSliderLabel;

    void sliderValueChanged(juce::Slider* slider);

    //juce::AudioProcessorValueTreeState::SliderAttachment xSliderAttachment;
    //juce::AudioProcessorValueTreeState::SliderAttachment ySliderAttachment;
    juce::AudioProcessorValueTreeState::SliderAttachment zSliderAttachment;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (SeamLess_ClientAudioProcessorEditor)
};
