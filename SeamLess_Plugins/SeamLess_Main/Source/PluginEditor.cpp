/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#include "PluginProcessor.h"
#include "PluginEditor.h"
#include "SeamLess_Main.h"

//==============================================================================
SeamLess_MainAudioProcessorEditor::SeamLess_MainAudioProcessorEditor (SeamLess_MainAudioProcessor& p, juce::AudioProcessorValueTreeState& apvts)
    : AudioProcessorEditor (&p), audioProcessor (p), reverbFaderBox(p,apvts)
{

    setSize (800,900);

    addAndMakeVisible(reverbFaderBox);

    addAndMakeVisible(incomingPortLabel);
    incomingPortLabel.setText("Set port for receiving OSC:", juce::dontSendNotification);
    incomingPortLabel.setColour (juce::Label::textColourId, juce::Colours::black);

    addAndMakeVisible(incomingPortText);
    incomingPortText.setText("-", juce::dontSendNotification);
    incomingPortText.setEditable (true);
    incomingPortText.setColour (juce::Label::backgroundColourId, juce::Colours::grey);


    incomingPortText.onTextChange = [this]
    {
        audioProcessor.setIncomingPort(incomingPortText.getText().getIntValue());
    };

    startTimer(100);
}

SeamLess_MainAudioProcessorEditor::~SeamLess_MainAudioProcessorEditor()
{
}

//==============================================================================
void SeamLess_MainAudioProcessorEditor::paint (juce::Graphics& g)
{
    g.setColour(seamlessBlue);
    g.fillRoundedRectangle(getLocalBounds().toFloat(), 20);

    g.setColour (juce::Colours::white);
    g.setFont (14.0f);
    g.drawText ("SeamLess Main Plugin", 20, 20, 200, 20,
    juce::Justification::left, true);
}


void SeamLess_MainAudioProcessorEditor::resized()
{

    reverbFaderBox.setBounds(100,200,300,600);

    incomingPortLabel.setBounds(100, 140, 220, 20);
    incomingPortText.setBounds(140, 180, 120, 20);
}



void SeamLess_MainAudioProcessorEditor::timerCallback()
{

    if(incomingPortText.isBeingEdited() == false)
        incomingPortText.setText(juce::String(audioProcessor.getIncomingPort()), juce::dontSendNotification);

}
