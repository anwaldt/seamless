/*
  ==============================================================================

    ReverbFaderBox.cpp
    Created: 31 Mar 2021 12:13:37am
    Author:  anwaldt

  ==============================================================================
*/

#include <JuceHeader.h>
#include "ReverbFaderBox.h"
#include "PluginProcessor.h"

//==============================================================================
ReverbFaderBox::ReverbFaderBox(SeamLess_MainAudioProcessor& p, juce::AudioProcessorValueTreeState& apvts):
    audioProcessor(p), treeState(apvts),
    revGainFader(p,apvts,"revGain"),
    revSizeFader(p,apvts,"revSize"),
    revColorFader(p,apvts,"revColor")
{

    revSizeFader.setText("Gain");
    revGainFader.setText("Size");
    revColorFader.setText("Color");

    addAndMakeVisible(revGainFader);
    addAndMakeVisible(revSizeFader);
    addAndMakeVisible(revColorFader);

}

ReverbFaderBox::~ReverbFaderBox()
{
}

void ReverbFaderBox::paint (juce::Graphics& g)
{
    g.setColour (juce::Colours::white);
    g.fillRoundedRectangle(getLocalBounds().toFloat(), 20);   // draw an outline around the component

    g.setColour (seamlessBlue);
    g.setFont (14.0f);
    g.drawText ("Reverb Parameters", 20, 20, 200, 20, juce::Justification::left, true);
}


void ReverbFaderBox::resized()
{
    revSizeFader.setBounds(120, 60,60,460);
    revGainFader.setBounds(30,60,60,460);
    revColorFader.setBounds(210,60,60,460);
//    sendFaderLFE.setBounds(370,60,60,460);
}


void ReverbFaderBox::sliderValueChanged (juce::Slider* slider)
{
    //    if (slider == &xSlider)
    //        xSlider.setValue (xSlider.getValue(), juce::dontSendNotification);

    //    if (slider == &ySlider)
    //        ySlider.setValue (ySlider.getValue(), juce::dontSendNotification);

    //    if (slider == &zSlider)
    //        zSlider.setValue (zSlider.getValue(), juce::dontSendNotification);
}
