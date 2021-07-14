/*
  ==============================================================================

    ClientConnection.h
    Created: 19 Mar 2021 4:14:08pm
    Author:  anwaldt

  ==============================================================================
*/


#pragma once

class SeamLess_ClientAudioProcessor;

#include <JuceHeader.h>
#include "PluginProcessor.h"

class ClientConnection : public juce::InterprocessConnection
{
public:

    ClientConnection(SeamLess_ClientAudioProcessor &p);

    bool mainConnection();

    void reconnect();


private:

    SeamLess_ClientAudioProcessor* processor;

    void connectionMade();
    void connectionLost();
    void messageReceived(const juce::MemoryBlock& msg);

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(ClientConnection);
};
