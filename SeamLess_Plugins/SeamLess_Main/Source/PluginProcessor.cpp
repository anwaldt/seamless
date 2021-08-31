/*
  ==============================================================================

    This file contains the basic framework code for a JUCE plugin processor.

  ==============================================================================
*/

#include "PluginProcessor.h"
#include "PluginEditor.h"

//==============================================================================
SeamLess_MainAudioProcessor::SeamLess_MainAudioProcessor()
    : parameters (*this, nullptr, juce::Identifier ("SeamLess_Main"),
{
                  std::make_unique<juce::AudioParameterFloat> ("revGain", "Reverb Gain", 0.0, 1.0, 0.0),
                  std::make_unique<juce::AudioParameterFloat> ("revFreq1", "Reverb Freq 1", 10.0, 20000.0, 500),
                  std::make_unique<juce::AudioParameterFloat> ("revFreq2", "Reverb Freq 2", 10.0, 20000.0, 1500.0),
                  std::make_unique<juce::AudioParameterFloat> ("revRdel", "Reverb Delay", 0.0, 100.0, 0.0),
                  std::make_unique<juce::AudioParameterFloat> ("revRgxyz", "Reverb Width", -9.0, 9.0, 0.0),
                  std::make_unique<juce::AudioParameterFloat> ("revT60dc", "Reverb T60 DC", 0.0, 10.0, 2.0),
                  std::make_unique<juce::AudioParameterFloat> ("revT60m", "Reverb T60 MID", 0.0, 10.0, 2.0),
                  std::make_unique<juce::AudioParameterFloat> ("revLpFreq", "Reverb LP Freq", 10.0, 20000.0, 1000.0),
                  std::make_unique<juce::AudioParameterFloat> ("revLpRs", "Reverb LP Slope", 0.0, 1.0, 0.5),
                  std::make_unique<juce::AudioParameterFloat> ("revLpDb", "Reverb Gain", -24.0, 6.0, -9.0)
                  }),
      AudioProcessor (BusesProperties())
{

    revGain   = parameters.getRawParameterValue("revGain");
    revFreq1  = parameters.getRawParameterValue("revFreq1");
    revFreq2  = parameters.getRawParameterValue("revFreq2");
    revRdel   = parameters.getRawParameterValue("revRdel");
    revRgxyz  = parameters.getRawParameterValue("revRgxyz");
    revT60dc  = parameters.getRawParameterValue("revT60dc");
    revT60m   = parameters.getRawParameterValue("revT60m");
    revLpFreq = parameters.getRawParameterValue("revLpFreq");
    revLpRs   = parameters.getRawParameterValue("revLpRs");
    revLpDb   = parameters.getRawParameterValue("revLpDb");

    // Register OSC paths
    // (this is used for remote controlling the client instances)
    juce::OSCReceiver::addListener(this, "/source/pos/x");
    juce::OSCReceiver::addListener(this, "/source/pos/y");
    juce::OSCReceiver::addListener(this, "/source/pos/z");

    juce::OSCReceiver::addListener(this, "/send/gain");

    beginWaitingForSocket(52713,"");

    startTimer(SEND_INTERVAL);
}

SeamLess_MainAudioProcessor::~SeamLess_MainAudioProcessor()
{
}

//==============================================================================
const juce::String SeamLess_MainAudioProcessor::getName() const
{
    return JucePlugin_Name;
}

bool SeamLess_MainAudioProcessor::acceptsMidi() const
{
#if JucePlugin_WantsMidiInput
    return true;
#else
    return false;
#endif
}

bool SeamLess_MainAudioProcessor::producesMidi() const
{
#if JucePlugin_ProducesMidiOutput
    return true;
#else
    return false;
#endif
}

bool SeamLess_MainAudioProcessor::isMidiEffect() const
{
#if JucePlugin_IsMidiEffect
    return true;
#else
    return false;
#endif
}

double SeamLess_MainAudioProcessor::getTailLengthSeconds() const
{
    return 0.0;
}

int SeamLess_MainAudioProcessor::getNumPrograms()
{
    return 1;   // NB: some hosts don't cope very well if you tell them there are 0 programs,
    // so this should be at least 1, even if you're not really implementing programs.
}

int SeamLess_MainAudioProcessor::getCurrentProgram()
{
    return 0;
}

void SeamLess_MainAudioProcessor::setCurrentProgram (int index)
{
}

const juce::String SeamLess_MainAudioProcessor::getProgramName (int index)
{
    return {};
}

void SeamLess_MainAudioProcessor::changeProgramName (int index, const juce::String& newName)
{
}

//==============================================================================
void SeamLess_MainAudioProcessor::prepareToPlay (double sampleRate, int samplesPerBlock)
{
}

void SeamLess_MainAudioProcessor::releaseResources()
{
}

#ifndef JucePlugin_PreferredChannelConfigurations
bool SeamLess_MainAudioProcessor::isBusesLayoutSupported (const BusesLayout& layouts) const
{
#if JucePlugin_IsMidiEffect
    juce::ignoreUnused (layouts);
    return true;
#else
    // This is the place where you check if the layout is supported.
    // In this template code we only support mono or stereo.
    // Some plugin hosts, such as certain GarageBand versions, will only
    // load plugins that support stereo bus layouts.
    if (layouts.getMainOutputChannelSet() != juce::AudioChannelSet::mono()
            && layouts.getMainOutputChannelSet() != juce::AudioChannelSet::stereo())
        return false;

    // This checks if the input layout matches the output layout
#if ! JucePlugin_IsSynth
    if (layouts.getMainOutputChannelSet() != layouts.getMainInputChannelSet())
        return false;
#endif

    return true;
#endif
}
#endif

void SeamLess_MainAudioProcessor::processBlock (juce::AudioBuffer<float>& buffer, juce::MidiBuffer& midiMessages)
{
    //    juce::ScopedNoDenormals noDenormals;
    //    auto totalNumInputChannels  = getTotalNumInputChannels();
    //    auto totalNumOutputChannels = getTotalNumOutputChannels();

    //    for (auto i = totalNumInputChannels; i < totalNumOutputChannels; ++i)
    //        buffer.clear (i, 0, buffer.getNumSamples());


    //    for (int channel = 0; channel < totalNumInputChannels; ++channel)
    //    {
    //        auto* channelData = buffer.getWritePointer (channel);

    //    }
}

//==============================================================================
bool SeamLess_MainAudioProcessor::hasEditor() const
{
    return true; // (change this to false if you choose to not supply an editor)
}

juce::AudioProcessorEditor* SeamLess_MainAudioProcessor::createEditor()
{
    return new SeamLess_MainAudioProcessorEditor (*this, parameters);
}

//==============================================================================

void SeamLess_MainAudioProcessor::getStateInformation (juce::MemoryBlock& destData)
{
    std::unique_ptr<juce::XmlElement> xml (new juce::XmlElement ("SeamLess_Main"));
    xml->setAttribute ("incomingPort", (int) incomingPort);
    copyXmlToBinary (*xml, destData);


    xml->setAttribute ("oscTargetAddress", (juce::String) oscTargetAddress);
    copyXmlToBinary (*xml, destData);

    xml->setAttribute ("oscTargetPort", (int) oscTargetPort);
    copyXmlToBinary (*xml, destData);

}

void SeamLess_MainAudioProcessor::setStateInformation (const void* data, int sizeInBytes)
{
    std::unique_ptr<juce::XmlElement> xmlState (getXmlFromBinary (data, sizeInBytes));

    if (xmlState.get() != nullptr)
    {
        if (xmlState->hasTagName ("SeamLess_Main"))
            setIncomingPort((int) xmlState->getIntAttribute("incomingPort", 1.0));
    }
    else
    {
        setIncomingPort(9001);
    }

    std::unique_ptr<juce::XmlElement> xmlState2 (getXmlFromBinary (data, sizeInBytes));

    if (xmlState2.get() != nullptr)
    {
        if (xmlState2->hasTagName ("SeamLess_Main"))
        {
            oscTargetAddress = (juce::String) xmlState2->getStringAttribute("oscTargetAddress");
            setOscTargetPort((int) xmlState2->getIntAttribute("oscTargetPort", 1.0));
        }
    }
}


juce::AudioProcessor* JUCE_CALLTYPE createPluginFilter()
{
    return new SeamLess_MainAudioProcessor();
}


void SeamLess_MainAudioProcessor::oscMessageReceived (const juce::OSCMessage& message)
{

    receiving = true;

    int nArgs = message.size();
    std::cout << "Main plugin: received OSC message with " << nArgs << " arguments!" <<  std::endl;

    juce::String path(message.getAddressPattern().toString());
    juce::String msg = path;

    // All position messages:
    if(path=="/source/pos/x" || path=="/source/pos/y" || path=="/source/pos/z")
    {
        if(nArgs==2 && message[0].isInt32() && message[1].isFloat32())
        {
            msg+= " "+juce::String(message[0].getInt32());
            msg+= " "+juce::String(message[1].getFloat32());
        }
    }

    // All send gains:
    if(path=="/send/gain")
    {
        if(nArgs==3 && message[0].isInt32() && message[1].isInt32() && (message[2].isFloat32() || message[2].isInt32()))
        {
            msg+= " "+juce::String(message[0].getInt32());
            msg+= " "+juce::String(message[1].getInt32());
            msg+= " "+juce::String(message[2].getFloat32());
        }
    }

    juce::MemoryBlock mb(msg.toRawUTF8(), msg.length());

    // loop over all connections and send message
    for(auto const& c: connections)
        c->sendMessage(mb);

}


juce::InterprocessConnection* SeamLess_MainAudioProcessor::createConnectionObject()
{

    MainConnection* c =  new MainConnection(stop_signal,this);
    connections.push_back(c);

    // std::cout << "HuFo main plugin received new connection! N=" << connections.size() << '\n';
    return c;

}


void SeamLess_MainAudioProcessor::setIncomingPort(int p)
{
    incomingPort = p;

    if (! connect (p))
        std::cout << "Can not open port!" << '\n';
    else
        std::cout << "Connected to port " << p << '\n';

}


int SeamLess_MainAudioProcessor::getIncomingPort()
{
    return incomingPort;
}


void SeamLess_MainAudioProcessor::removeClosedConnections()
{

    for (auto it = begin(connections); it != end(connections);) {
        if ((*it)->isConnected()==false)
            it = connections.erase(it);
        else
            ++it;
    }
}


juce::AudioProcessorValueTreeState& SeamLess_MainAudioProcessor::getState()
{
    return parameters;
}

void SeamLess_MainAudioProcessor::parameterChanged(const juce::String & id, float val)
{

}


void SeamLess_MainAudioProcessor::revGainSend()
{}

void SeamLess_MainAudioProcessor::revSizeSend()
{}

void SeamLess_MainAudioProcessor::revColorSend()
{}


void SeamLess_MainAudioProcessor::setOscTargetPort(int port)
{
    oscTargetPort = port;
    oscSender.disconnect();
    oscSender.connect(oscTargetAddress, oscTargetPort);
    std::cout << "Switched OSC target (from port change): " << oscTargetAddress << ":" << oscTargetPort << '\n';
}

void SeamLess_MainAudioProcessor::setOscTargetAddress(juce::String address)
{
    oscTargetAddress = address;
    oscSender.disconnect();
    oscSender.connect(oscTargetAddress, oscTargetPort);
    std::cout << "Switched OSC target (from address change): " << oscTargetAddress << ":" << oscTargetPort << '\n';
}



int SeamLess_MainAudioProcessor::getOscTargetPort()
{
    return oscTargetPort;
}

juce::String  SeamLess_MainAudioProcessor::getOscTargetAddress()
{
    return oscTargetAddress;
}



bool SeamLess_MainAudioProcessor::getSendState()
{
    return isSending;
}

void SeamLess_MainAudioProcessor::setSendState(bool s)
{
    isSending=s;
}


bool SeamLess_MainAudioProcessor::getReceivingState()
{
    return receiving;
}

void SeamLess_MainAudioProcessor::setReceivingState(bool s)
{
    receiving = s;
}


void SeamLess_MainAudioProcessor::hiResTimerCallback()
{

    float in = (float) *revGain;
    juce::OSCMessage m = juce::OSCMessage("/reverb/gain", in);
    oscSender.send(m);

    in = (float) *revFreq1;
    m = juce::OSCMessage("/reverb/f1", in);
    oscSender.send(m);

    in = (float) *revFreq2;
    m = juce::OSCMessage("/reverb/f2", in);
    oscSender.send(m);

    in = (float) *revRdel;
    m = juce::OSCMessage("/reverb/rdel", in);
    oscSender.send(m);

    in = (float) *revRgxyz;
    m = juce::OSCMessage("/reverb/rgxyz", in);
    oscSender.send(m);

    in = (float) *revT60dc;
    m = juce::OSCMessage("/reverb/t60dc", in);
    oscSender.send(m);

    in = (float) *revT60m;
    m = juce::OSCMessage("/reverb/t60m", in);
    oscSender.send(m);

    in = (float) *revLpFreq;
    m = juce::OSCMessage("/reverb/lp/freq", in);
    oscSender.send(m);

    in = (float) *revLpRs;
    m = juce::OSCMessage("/reverb/lp/rs", in);
    oscSender.send(m);

    in = (float) *revLpDb;
    m = juce::OSCMessage("/reverb/lp/db", in);
    oscSender.send(m);

}



