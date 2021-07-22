/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin editor.

  ==============================================================================
*/

#include "PluginProcessor.h"
#include "PluginEditor.h"
#include "../../Common/SeamLess.h"

//==============================================================================
SeamLess_MainAudioProcessorEditor::SeamLess_MainAudioProcessorEditor (SeamLess_MainAudioProcessor& p, juce::AudioProcessorValueTreeState& apvts)
    : AudioProcessorEditor (&p), audioProcessor (p), oscConnectionBox(p), reverbFaderBox(p,apvts), connectionComponent(&p)
{

    setSize (1400,800);

    addAndMakeVisible(oscConnectionBox);

    addAndMakeVisible(reverbFaderBox);

    addAndMakeVisible(connectionComponent);

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

    oscConnectionBox.setBounds(60,60,200,180);

    reverbFaderBox.setBounds(360,60,940,600);

    connectionComponent.setBounds(40, 640, 300, 120);

}


void SeamLess_MainAudioProcessorEditor::timerCallback()
{

}
