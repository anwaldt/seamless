/*
  ==============================================================================

    SendFaderBox.cpp
    Created: 31 Mar 2021 12:13:37am
    Author:  anwaldt

  ==============================================================================
*/

#include <JuceHeader.h>
#include "SendFaderBox.h"
#include "PluginProcessor.h"

//==============================================================================
SendFaderBox::SendFaderBox(SeamLess_ClientAudioProcessor& p, juce::AudioProcessorValueTreeState& apvts):
    audioProcessor(p), treeState(apvts),
    sendFaderHOA(p,apvts,"sendGainHOA"),
    sendFaderWFS(p,apvts,"sendGainWFS"),
    sendFaderREV(p,apvts,"sendGainREV")
//    sendFaderLFE(p,apvts,"sendGainLFE")
{

    sendFaderWFS.setText("WFS");
    sendFaderHOA.setText("HOA");
    sendFaderREV.setText("REV");
//    sendFaderLFE.setText("LFE");

    addAndMakeVisible(sendFaderHOA);
    addAndMakeVisible(sendFaderWFS);
    addAndMakeVisible(sendFaderREV);
   // addAndMakeVisible(sendFaderLFE);

    // sendFaderWFS.addListener(this);

}

SendFaderBox::~SendFaderBox()
{
}

void SendFaderBox::paint (juce::Graphics& g)
{
    g.setColour (seamlessBlue);
    g.fillRoundedRectangle(getLocalBounds().toFloat(), 20);   // draw an outline around the component

    g.setColour (juce::Colours::white);
    g.setFont (14.0f);
    g.drawText ("Send Levels", 20, 20, 200, 20, juce::Justification::left, true);
}


void SendFaderBox::resized()
{
    sendFaderWFS.setBounds(120, 60,60,460);
    sendFaderHOA.setBounds(30,60,60,460);
    sendFaderREV.setBounds(210,60,60,460);
//    sendFaderLFE.setBounds(370,60,60,460);
}


void SendFaderBox::sliderValueChanged (juce::Slider* slider)
{
    //    if (slider == &xSlider)
    //        xSlider.setValue (xSlider.getValue(), juce::dontSendNotification);

    //    if (slider == &ySlider)
    //        ySlider.setValue (ySlider.getValue(), juce::dontSendNotification);

    //    if (slider == &zSlider)
    //        zSlider.setValue (zSlider.getValue(), juce::dontSendNotification);
}
