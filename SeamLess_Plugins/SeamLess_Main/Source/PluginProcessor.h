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


    void revGainSend();
    void revSizeSend();
    void revColorSend();

    bool getReceivingState();
    void setReceivingState(bool s);

    void setOscTargetAddress(juce::String address);
    void setOscTargetPort(int port);

    bool getSendState();
    void setSendState(bool s);

    juce::String  getOscTargetAddress();
    int getOscTargetPort();

private:

    /// \brief incomingPort
    /// Port for incoming OSC connections to main plugin.
    int incomingPort = 9001;

    // The AudioProcessorValueTreeState connects parameters to the GUI
    // and manages serialization
    juce::AudioProcessorValueTreeState parameters;

    // IP address and port are used by all instances
    juce::String oscTargetAddress;
    int oscTargetPort;
    juce::OSCSender oscSender;

    juce::AudioPlayHead::CurrentPositionInfo playInfo;

    bool isSending   = true;
    bool playSending = true;

    std::atomic<float>* revGain   = nullptr;
    std::atomic<float>* revFreq1  = nullptr;
    std::atomic<float>* revFreq2  = nullptr;
    std::atomic<float>* revRdel   = nullptr;
    std::atomic<float>* revRgxyz  = nullptr;
    std::atomic<float>* revT60dc  = nullptr;
    std::atomic<float>* revT60m   = nullptr;
    std::atomic<float>* revLpFreq = nullptr;
    std::atomic<float>* revLpRs   = nullptr;
    std::atomic<float>* revLpDb   = nullptr;

    /// \brief oscMessageReceived
    /// \param message
    ///
    /// Passes incoming OSC messages to all client instances.
    ///
    /// @todo: Change from string to a more efficient interprocess protocol!
    void oscMessageReceived (const juce::OSCMessage& message) override;

    ///
    /// \brief receiving
    /// used to indicate whether any OSC message has reached the plugin
    bool receiving;

    /// Interconnection Stuff ====================================================================
    juce::WaitableEvent stop_signal;

    std::vector<MainConnection*> connections;

    juce::InterprocessConnection* createConnectionObject();

    ///
    /// \brief hiResTimerCallback
    /// Send all OSC commands with a timer call.
    void hiResTimerCallback();

    //==============================================================================
    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (SeamLess_MainAudioProcessor)
};
