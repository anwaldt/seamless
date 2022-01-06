/*
  ==============================================================================

    SendFader.cpp
    Created: 31 Mar 2021 10:34:35am
    Author:  anwaldt

  ==============================================================================
*/

#include <JuceHeader.h>
#include "ReverbFader.h"

//==============================================================================
ReverbFader::ReverbFader(SeamLess_MainAudioProcessor &p, juce::AudioProcessorValueTreeState &apvts,juce::String s):
    sliderAttachment(p.getState(),s,this->slider)
{

    slider.setSliderStyle (juce::Slider::LinearVertical);
    slider.setTextBoxStyle (juce::Slider::TextBoxBelow, false, 90, 30);
    slider.setColour(juce::Slider::textBoxTextColourId, juce::Colours::black);
    slider.setColour(juce::Slider::textBoxOutlineColourId, juce::Colours::grey);
    addAndMakeVisible(slider);

    // sendNameLabel.attachToComponent (&slider, false);
    sendNameLabel.setColour (juce::Label::textColourId, juce::Colours::white);
    sendNameLabel.setJustificationType (juce::Justification::centred);
    sendNameLabel.setText ("SND", juce::dontSendNotification);
    sendNameLabel.attachToComponent(&slider,false);

    addAndMakeVisible (sendNameLabel);

}

ReverbFader::~ReverbFader()
{
}

void ReverbFader::paint (juce::Graphics& g)
{
    g.setColour (juce::Colours::grey);
    g.fillRoundedRectangle(getLocalBounds().toFloat(), 10);   // draw an outline around the component
}

void ReverbFader::resized()
{
    slider.setBounds(0,40,60,400);
}

void ReverbFader::setText(juce::String s)
{
    sendNameLabel.setText (s, juce::dontSendNotification);
}
