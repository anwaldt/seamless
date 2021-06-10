/*
  ==============================================================================

    SourceSettingsComponent.cpp
    Created: 10 Apr 2021 10:58:19pm
    Author:  anwaldt

  ==============================================================================
*/

#include <JuceHeader.h>
#include "SourceSettingsComponent.h"

SourceSettingsComponent::SourceSettingsComponent(SeamLess_ClientAudioProcessor *a, juce::AudioProcessorValueTreeState &apvts):
    sourceIndex(*apvts.getParameter("sourceIdx"))
{
    processor = a;

    addAndMakeVisible (inputLabel);
    inputLabel.setText ("Source Index:", juce::dontSendNotification);
    inputLabel.attachToComponent (&sourceIndText, true);
    inputLabel.setColour (juce::Label::textColourId, juce::Colours::black);
    inputLabel.setJustificationType (juce::Justification::right);

    addAndMakeVisible (sourceIndText);
    sourceIndText.setEditable (true);
    sourceIndText.setColour (juce::Label::backgroundColourId, seamlessBlue);

    sourceIndText.onTextChange = [this]
    {
        juce::String s = sourceIndText.getText();
        // sourceIndex.setValue( s.getIntValue());
        processor->setSourceIndex(s.getIntValue());
    };
    // xSliderAttachment     = new juce::AudioProcessorValueTreeState::SliderAttachment ();

    //*valueTreeState.getParameter("sourceIdx"),
    sourceIndText.setText(sourceIndex.getCurrentValueAsText(),juce::dontSendNotification);



    startTimer(100);

}

SourceSettingsComponent::~SourceSettingsComponent()
{
}

void SourceSettingsComponent::paint (juce::Graphics& g)
{
    g.setColour(juce::Colour (220,220,220));
    g.fillRoundedRectangle(0,0,getWidth(),getHeight(),30);

    g.setColour(seamlessBlue);
    g.drawRoundedRectangle(0,0,getWidth(),getHeight(),30,15);

    g.setColour (seamlessBlue);
    g.setFont (14.0f);
    g.drawText ("SeamLess Client Plugin", 20, 20, 200, 20,
                juce::Justification::left, true);   // draw some placeholder text

}

void SourceSettingsComponent::resized()
{
    sourceIndText.setBounds(270, getHeight()/2 -10, 50, 20);
}


void SourceSettingsComponent::timerCallback()
{
    if(sourceIndText.isBeingEdited() == false)
        sourceIndText.setText(juce::String(processor->getSourceIndex()), juce::dontSendNotification);
}

