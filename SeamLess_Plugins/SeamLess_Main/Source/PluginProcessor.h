/*
  ==============================================================================
  
    This file contains the basic framework code for a JUCE plugin processor.
    
  ==============================================================================
*/

#pragma once

class MainConnection;

#include <JuceHeader.h>
#include "MainConnection.h"

//==============================================================================
/**
*/
class SeamLess_MainAudioProcessor  :
        public juce::AudioProcessor,
        juce::InterprocessConnectionServer,
        private juce::OSCReceiver,
        juce::OSCReceiver::ListenerWithOSCAddress<juce::OSCReceiver::MessageLoopCallback>
{
public:
    //==============================================================================
    SeamLess_MainAudioProcessor();
    ~SeamLess_MainAudioProcessor() override;
    
    //==============================================================================
    void prepareToPlay (double sampleRate, int samplesPerBlock) override;
    void releaseResources() override;
    
#ifndef JucePlugin_PreferredChannelConfigurations
    bool isBusesLayoutSupported (const BusesLayout& layouts) const override;
#endif
    
    void processBlock (juce::AudioBuffer<float>&, juce::MidiBuffer&) override;
    
    //==============================================================================
    juce::AudioProcessorEditor* createEditor() override;
    bool hasEditor() const override;
    
    //==============================================================================
    const juce::String getName() const override;
    
    bool acceptsMidi() const override;
    bool producesMidi() const override;
    bool isMidiEffect() const override;
    double getTailLengthSeconds() const override;
    
    //==============================================================================
    int getNumPrograms() override;
    int getCurrentProgram() override;
    void setCurrentProgram (int index) override;
    const juce::String getProgramName (int index) override;
    void changeProgramName (int index, const juce::String& newName) override;
    
    //==============================================================================
    void getStateInformation (juce::MemoryBlock& destData) override;
    void setStateInformation (const void* data, int sizeInBytes) override;

    //==============================================================================
    void setIncomingPort(int p);
    int getIncomingPort();

    /// \brief removeClosedConnections
    ///
    /// Check for unconnected main connection objects and remove them from the vecor.
    void removeClosedConnections();


private:
    
    int incomingPort = 52713;

    /// \brief oscMessageReceived
    /// \param message
    ///
    /// Passes incoming OSC messages to all client instances.
    ///
    /// @todo: Change from string to a more efficient interprocess protocol!
    void oscMessageReceived (const juce::OSCMessage& message) override;
    
    /// Interconnection Stuff ====================================================================
    juce::WaitableEvent stop_signal;
    
    std::vector<MainConnection*> connections;
    
    juce::InterprocessConnection* createConnectionObject();

    
    //==============================================================================
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (SeamLess_MainAudioProcessor)
};
