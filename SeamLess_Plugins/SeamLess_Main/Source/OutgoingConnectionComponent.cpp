/*
  ==============================================================================

    OutgoingConnectionComponent.cpp
    Created: 24 Mar 2021 10:31:46pm
    Author:  anwaldt

  ==============================================================================
*/

#include <JuceHeader.h>
#include "OutgoingConnectionComponent.h"

//==============================================================================
OutgoingConnectionComponent::OutgoingConnectionComponent(SeamLess_MainAudioProcessor *a)
{
    audioProcessor = a;

    addAndMakeVisible(oscTargetAddressText);
    oscTargetAddressText.setText("loco", juce::dontSendNotification);
    oscTargetAddressText.setColour (juce::Label::textColourId, juce::Colours::black);
    oscTargetAddressText.setColour (juce::Label::backgroundColourId, seamlessBlue);
    oscTargetAddressText.setJustificationType (juce::Justification::right);
    oscTargetAddressText.setEditable (true);
    oscTargetAddressText.onTextChange = [this]
    {
        juce::String s = oscTargetAddressText.getText();
        audioProcessor->setOscTargetAddress(s);
    };


    addAndMakeVisible(oscTargetPortText);
    oscTargetPortText.setText("mot", juce::dontSendNotification);
    oscTargetPortText.setColour (juce::Label::textColourId, juce::Colours::black);
    oscTargetPortText.setColour (juce::Label::backgroundColourId, seamlessBlue);
    oscTargetPortText.setJustificationType (juce::Justification::right);
    oscTargetPortText.setEditable (true);
    oscTargetPortText.onTextChange = [this]
    {
        audioProcessor->setOscTargetPort(oscTargetPortText.getText().getIntValue());
    };

    addAndMakeVisible(sendButton);
    sendButton.onClick = [this]
    {
        audioProcessor->setSendState(sendButton.getToggleStateValue().getValue());
    };

    startTimer(100);
}

OutgoingConnectionComponent::~OutgoingConnectionComponent()
{

}

void OutgoingConnectionComponent::paint (juce::Graphics& g)
{

    g.setColour (juce::Colours::grey);
    g.fillRoundedRectangle(getLocalBounds().toFloat(), 20);   // draw an outline around the component

    g.setColour (seamlessBlue);
    g.setFont (14.0f);
    g.drawText ("Outgoing Connection (Main Plugin)", 20, 20, 200, 20,
                juce::Justification::left, true);   // draw some placeholder text


}

void OutgoingConnectionComponent::resized()
{
    oscTargetAddressText.setBounds(40, 80, 120, 20);
    oscTargetPortText.setBounds(180, 80, 80, 20);
    sendButton.setBounds(40,50,80,20);
}


void OutgoingConnectionComponent::timerCallback()
{
    // update text boxes only if they are not being edited
    if(oscTargetAddressText.isBeingEdited() == false)
        oscTargetAddressText.setText(audioProcessor->getOscTargetAddress(), juce::dontSendNotification);

    if(oscTargetPortText.isBeingEdited() == false)
        oscTargetPortText.setText(juce::String(audioProcessor->getOscTargetPort()), juce::dontSendNotification);

    sendButton.setToggleState(audioProcessor->getSendState(), juce::dontSendNotification);

}
