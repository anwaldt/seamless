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
    revFreq1Fader(p,apvts,"revFreq1"),
    revFreq2Fader(p,apvts,"revFreq2"),
    revRdelFader(p,apvts,"revRdel"),
    revRgxyzFader(p,apvts,"revRgxyz"),
    revT60dcFader(p,apvts,"revT60dc"),
    revT60mFader(p,apvts,"revT60m"),
    revLpFreqFader(p,apvts,"revLpFreq"),
    revLpRsFader(p,apvts,"revLpRs"),
    revLpDbFader(p,apvts,"revLpDb")
{

    addAndMakeVisible( revGainFader);
    addAndMakeVisible( revFreq1Fader);
    addAndMakeVisible( revFreq2Fader);
    addAndMakeVisible( revRdelFader);
    addAndMakeVisible( revRgxyzFader);
    addAndMakeVisible( revT60dcFader);
    addAndMakeVisible( revT60mFader);
    addAndMakeVisible( revLpFreqFader);
    addAndMakeVisible( revLpRsFader);
    addAndMakeVisible( revLpDbFader);


      revGainFader.setText("Gain");
      revFreq1Fader.setText("Freq 1");
      revFreq2Fader.setText("Freq 2");
      revRdelFader.setText("Delay");
      revRgxyzFader.setText("Width");
      revT60dcFader.setText("T60 DC");
      revT60mFader.setText("T60 MID");
      revLpFreqFader.setText("LP Cutoff");
      revLpRsFader.setText("LP Slope");
      revLpDbFader.setText("LP Gain");

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


    revGainFader.setBounds(30, 60,60,460);
    revFreq1Fader.setBounds(120,60,60,460);
    revFreq2Fader.setBounds(210,60,60,460);
    revRdelFader.setBounds(300,60,60,460);
    revRgxyzFader.setBounds(390,60,60,460);
    revT60dcFader.setBounds(480,60,60,460);
    revT60mFader.setBounds(570,60,60,460);
    revLpFreqFader.setBounds(660,60,60,460);
    revLpRsFader.setBounds(750,60,60,460);
    revLpDbFader.setBounds(840,60,60,460);


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
