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
        juce::AudioProcessorValueTreeState::Listener,
        juce::InterprocessConnectionServer,
        private juce::OSCReceiver,
        juce::OSCReceiver::ListenerWithOSCAddress<juce::OSCReceiver::MessageLoopCallback>,
        juce::HighResolutionTimer
{
public:
    //==============================================================================
    SeamLess_MainAudioProcessor();
    ~SeamLess_MainAudioProcessor() override;

    virtual void parameterChanged(const juce::String & id, float val) override;

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

    ///
    /// \brief setStateInformation
    /// \param data
    /// \param sizeInBytes
    /// Restore plugin settings from last session.
    void setStateInformation (const void* data, int sizeInBytes) override;

    //==============================================================================
    void setIncomingPort(int p);
    int getIncomingPort();

    /// \brief removeClosedConnections
    ///
    /// Check for unconnected main connection objects and remove them from the vecor.
    void removeClosedConnections();

    juce::AudioProcessorValueTreeState& getState();

    juce::String oscTargetAddress;
    int oscTargetPort;
    juce::OSCSender oscSender;

    void revGainSend();
    void revSizeSend();
    void revColorSend();

    void setOscTargetPort(int port);


private:

    /// \brief incomingPort
    /// Port for incoming OSC connections to main plugin.
    int incomingPort = 9001;

    // The AudioProcessorValueTreeState connects parameters to the GUI
    // and manages serialization
    juce::AudioProcessorValueTreeState parameters;


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

    void hiResTimerCallback();

    //==============================================================================
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (SeamLess_MainAudioProcessor)
};
