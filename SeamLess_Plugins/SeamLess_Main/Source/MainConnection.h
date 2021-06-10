/*
  ==============================================================================

    Connection.h
    Created: 19 Mar 2021 2:52:36pm
    Author:  anwaldt

  ==============================================================================
*/

#pragma once

class SeamLess_MainAudioProcessor;

#include <JuceHeader.h>
#include "PluginProcessor.h"

class MainConnection : public juce::InterprocessConnection
{
public:
    MainConnection(juce::WaitableEvent& stop_signal, SeamLess_MainAudioProcessor *p);

    void connectionMade();

    ///
    /// \brief connectionLost
    /// If a MainConnection object loses its connection,
    /// it calls the processor's removeClosedConnections method
    /// for deleting all disconnected MainConnections.
    void connectionLost();

    void messageReceived(const juce::MemoryBlock& msg);

private:

    SeamLess_MainAudioProcessor *processor;
    juce::WaitableEvent& stop_signal_;

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR(MainConnection);
};
