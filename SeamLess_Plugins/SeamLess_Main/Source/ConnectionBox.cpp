/*
  ==============================================================================

    ConnectionBox.cpp
    Created: 15 Jul 2021 12:02:09pm
    Author:  anwaldt

  ==============================================================================
*/

#include <JuceHeader.h>
#include "ConnectionBox.h"

//==============================================================================
ConnectionBox::ConnectionBox(SeamLess_MainAudioProcessor &p) : audioProcessor(p)
{
    addAndMakeVisible(incomingPortLabel);
    incomingPortLabel.setText("Port for receiving OSC", juce::dontSendNotification);
    incomingPortLabel.setColour (juce::Label::textColourId, juce::Colours::black);

    addAndMakeVisible(incomingPortText);
    incomingPortText.setText("-", juce::dontSendNotification);
    incomingPortText.setEditable (true);
    incomingPortText.setColour (juce::Label::backgroundColourId, juce::Colours::grey);

    addAndMakeVisible(receiveOscButton);
    receiveOscButton.setButtonText("Receiving OSC");

    incomingPortText.onTextChange = [this]
    {
        audioProcessor.setIncomingPort(incomingPortText.getText().getIntValue());
    };

    startTimer(100);

}

ConnectionBox::~ConnectionBox()
{
}

void ConnectionBox::paint (juce::Graphics& g)
{

    g.setColour (juce::Colours::white);
    g.fillRoundedRectangle(getLocalBounds().toFloat(), 20);   // draw an outline around the component

}

void ConnectionBox::resized()
{

    incomingPortLabel.setBounds(15, 20, 220, 20);
    incomingPortText.setBounds(30, 50, 120, 20);

    receiveOscButton.setBounds(60,100,60,30);
}



void ConnectionBox::timerCallback()
{

    if(incomingPortText.isBeingEdited() == false)

        incomingPortText.setText(juce::String(audioProcessor.getIncomingPort()), juce::dontSendNotification);

    bool rs = audioProcessor.getReceivingState();

    if(rs==true)
    {
        receiveOscButton.setColour(juce::TextButton::buttonColourId,juce::Colours::green);
        audioProcessor.setReceivingState(false);
    }
    else
    {
        receiveOscButton.setColour(juce::TextButton::buttonColourId,juce::Colours::grey);
    }
}
