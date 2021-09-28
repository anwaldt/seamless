#include "PluginProcessor.h"
#include "PluginEditor.h"

//==============================================================================

// initialize static members
juce::String SeamLess_ClientAudioProcessor::oscTargetAddress("127.0.0.1");
int SeamLess_ClientAudioProcessor::oscTargetPort(9001);


bool SeamLess_ClientAudioProcessor::isSending   = false;
bool SeamLess_ClientAudioProcessor::playSending = false;

juce::OSCSender SeamLess_ClientAudioProcessor::sender1;

SeamLess_ClientAudioProcessor::SeamLess_ClientAudioProcessor()
    : parameters (*this, nullptr, juce::Identifier ("HuFo"),
{
                  std::make_unique<juce::AudioParameterFloat> ("xPos", "X Position", -10.0, 10.0, 0.0),
                  std::make_unique<juce::AudioParameterFloat> ("yPos", "Y Position", -10.0, 10.0, 0.0),
                  std::make_unique<juce::AudioParameterFloat> ("zPos", "Z Position", -10.0, 10.0, 0.0),
                  std::make_unique<juce::AudioParameterFloat> ("sendGainWFS", "Send Gain: WFS", 0, 1.0, 0.0),
                  std::make_unique<juce::AudioParameterFloat> ("sendGainHOA", "Send Gain: HOA", 0, 1.0, 0.0),
                  std::make_unique<juce::AudioParameterFloat> ("sendGainREV", "Send Gain: REV", 0, 1.0, 0.0),
//                  std::make_unique<juce::AudioParameterFloat> ("sendGainLFE", "Send Gain: LFE", 0, 1.0, 0.0),
                  std::make_unique<juce::AudioParameterInt>   ("sourceIdx", "Source Index", -1, 128, -1)
                  }),
      client(new ClientConnection(*this)),
      AudioProcessor (BusesProperties()) // use no audio buses
{

    sender1.connect(oscTargetAddress, 9001);

    // get pointers to individual parameters from the ValueTreeState
    sourceIdx = (juce::AudioParameterInt*) parameters.getParameter("sourceIdx");

    xPos      = parameters.getRawParameterValue("xPos");
    yPos      = parameters.getRawParameterValue("yPos");
    zPos      = parameters.getRawParameterValue("zPos");

    sendGainWFS      = parameters.getRawParameterValue("sendGainWFS");
    sendGainHOA      = parameters.getRawParameterValue("sendGainHOA");
    sendGainREV      = parameters.getRawParameterValue("sendGainREV");
//    sendGainLFE      = parameters.getRawParameterValue("sendGainLFE");


    // add a listener for every parameter to make it trigger parameterChanged()
    parameters.addParameterListener("xPos", this);
    parameters.addParameterListener("yPos", this);
    parameters.addParameterListener("zPos", this);

    parameters.addParameterListener("sendGainWFS", this);
    parameters.addParameterListener("sendGainHOA", this);
    parameters.addParameterListener("sendGainREV", this);
//    parameters.addParameterListener("sendGainLFE", this);

    client->connectToSocket("localhost", port_nr, 5000);

    setSendState(true);

    startTimer(SEND_INTERVAL);

}

SeamLess_ClientAudioProcessor::~SeamLess_ClientAudioProcessor()
{
}

//==============================================================================
const juce::String SeamLess_ClientAudioProcessor::getName() const
{
    return JucePlugin_Name;
}

bool SeamLess_ClientAudioProcessor::acceptsMidi() const
{
    return false;
}

bool SeamLess_ClientAudioProcessor::producesMidi() const
{
    return false;
}

bool SeamLess_ClientAudioProcessor::isMidiEffect() const
{
    return false;
}

double SeamLess_ClientAudioProcessor::getTailLengthSeconds() const
{
    return 0.0;
}

int SeamLess_ClientAudioProcessor::getNumPrograms()
{
    return 1;
}

int SeamLess_ClientAudioProcessor::getCurrentProgram()
{
    return 0;
}

void SeamLess_ClientAudioProcessor::setCurrentProgram (int index)
{
}

const juce::String SeamLess_ClientAudioProcessor::getProgramName (int index)
{
    return {};
}

void SeamLess_ClientAudioProcessor::changeProgramName (int index, const juce::String& newName)
{
}

//==============================================================================
void SeamLess_ClientAudioProcessor::prepareToPlay (double sampleRate, int samplesPerBlock)
{
    //isSending=true;
}

void SeamLess_ClientAudioProcessor::releaseResources()
{
    //isSending=false;
}


void SeamLess_ClientAudioProcessor::processBlock (juce::AudioBuffer<float>& buffer, juce::MidiBuffer& midiMessages)
{
    juce::ScopedNoDenormals noDenormals;
    auto totalNumInputChannels  = getTotalNumInputChannels();
    auto totalNumOutputChannels = getTotalNumOutputChannels();

    auto* ph = getPlayHead();
    ph->getCurrentPosition(playInfo);
    playSending = playInfo.isPlaying;

}

bool SeamLess_ClientAudioProcessor::hasEditor() const
{
    return true;
}

juce::AudioProcessorEditor* SeamLess_ClientAudioProcessor::createEditor()
{
    return new SeamLess_ClientAudioProcessorEditor (*this, parameters);
}


void SeamLess_ClientAudioProcessor::getStateInformation (juce::MemoryBlock& destData)
{

    // for the tree only:
    auto state = parameters.copyState();
    std::unique_ptr<juce::XmlElement> xml (state.createXml());
    copyXmlToBinary (*xml, destData);

    // for additional parameters:
    std::unique_ptr<juce::XmlElement> xml2 (new juce::XmlElement ("HoFo_Client"));

    xml2->setAttribute ("oscTargetAddress", (juce::String) oscTargetAddress);
    copyXmlToBinary (*xml2, destData);

    xml2->setAttribute ("oscTargetPort", (int) oscTargetPort);
    copyXmlToBinary (*xml2, destData);
}

void SeamLess_ClientAudioProcessor::setStateInformation (const void* data, int sizeInBytes)
{

    // for the tree only:
    std::unique_ptr<juce::XmlElement> xmlState (getXmlFromBinary (data, sizeInBytes));
    if (xmlState.get() != nullptr)
        if (xmlState->hasTagName (parameters.state.getType()))
            parameters.replaceState (juce::ValueTree::fromXml (*xmlState));


    // for additional parameters:

    std::unique_ptr<juce::XmlElement> xmlState2 (getXmlFromBinary (data, sizeInBytes));

    if (xmlState2.get() != nullptr)
    {
        if (xmlState2->hasTagName ("HoFo_Client"))
        {
            oscTargetAddress = (juce::String) xmlState2->getStringAttribute("oscTargetAddress");
            setOscTargetPort((int) xmlState2->getIntAttribute("oscTargetPort", 1.0));
        }
    }

}



float SeamLess_ClientAudioProcessor::getXPos()
{
    return (float) *xPos;
}

float SeamLess_ClientAudioProcessor::getYPos()
{
    return (float) *yPos;
}

float SeamLess_ClientAudioProcessor::getZPos()
{
    return (float) *zPos;
}


void SeamLess_ClientAudioProcessor::setXPos(float in)
{
    //*xPos = in;
    juce::Value val = parameters.getParameterAsValue("xPos");
    val.setValue(juce::var(in));
}

void SeamLess_ClientAudioProcessor::setYPos(float in)
{
    // *yPos = in;
    juce::Value val = parameters.getParameterAsValue("yPos");
    val.setValue(juce::var(in));
}

void SeamLess_ClientAudioProcessor::setZPos(float in)
{
    //*zPos = in;
    juce::Value val = parameters.getParameterAsValue("zPos");
    val.setValue(juce::var(in));
}


void SeamLess_ClientAudioProcessor::xPosSend()
{
    int i = (int) *sourceIdx;
    float in = (float) *xPos;
    juce::OSCMessage m = juce::OSCMessage("/source/pos/x",i, in);
    sender1.send(m);
}

void SeamLess_ClientAudioProcessor::yPosSend()
{
    int i = (int) *sourceIdx;
    float in = (float) *yPos;

    juce::OSCMessage   m = juce::OSCMessage("/source/pos/y",i, in);
    sender1.send(m);
}

void SeamLess_ClientAudioProcessor::zPosSend()
{
    int i = (int) *sourceIdx;
    float in = (float) *zPos;
    juce::OSCMessage m = juce::OSCMessage("/source/pos/z",i, in);
    sender1.send(m);
}

void SeamLess_ClientAudioProcessor::xyzPosSend()
{
    int i = (int) *sourceIdx;
    float x = (float) *xPos;
    float y = (float) *xPos;
    float z = (float) *xPos;

    juce::OSCMessage m = juce::OSCMessage("/source/pos/xyz",i,x,y,z);
    sender1.send(m);
}


void SeamLess_ClientAudioProcessor::sendGainSend()
{
    int i = (int) *sourceIdx;
    juce::OSCMessage m = juce::OSCMessage("/send/gain",i, 0, 0);

    float in = (float) *sendGainHOA;
    m = juce::OSCMessage("/send/gain",i, 0, in);
    sender1.send(m);

    in = (float) *sendGainWFS;
    m = juce::OSCMessage("/send/gain",i, 1, in);
    sender1.send(m);

    in = (float) *sendGainREV;
    m = juce::OSCMessage("/send/gain",i, 2, in);
    sender1.send(m);

//    in = (float) *sendGainLFE;
//    m = juce::OSCMessage("/send/gain",i, 3, in);
//    sender1.send(m);

}

void SeamLess_ClientAudioProcessor::setSendGain(int sendIndex, float in)
{

    juce::Value val;

    switch (sendIndex)
    {
    case 0:
        val = parameters.getParameterAsValue("sendGainHOA");
        val.setValue(juce::var(in));
        break;
    case 1:
        val = parameters.getParameterAsValue("sendGainWFS");
        val.setValue(juce::var(in));
        break;
    case 2:
        val = parameters.getParameterAsValue("sendGainREV");
        val.setValue(juce::var(in));
        break;
//    case 3:
//        val = parameters.getParameterAsValue("sendGainLFE");
//        val.setValue(juce::var(in));
//        break;

    default:
        break;
    }

}


void SeamLess_ClientAudioProcessor::setSourceIndex(int i)
{
    juce::Identifier id ("sourceIdx");
    *sourceIdx = i;
    std::cout << "Switched source index: " << *parameters.getRawParameterValue("sourceIdx") << '\n';
}

int SeamLess_ClientAudioProcessor::getSourceIndex()
{
    return *sourceIdx;
}


void SeamLess_ClientAudioProcessor::setOscTargetAddress(juce::String address)
{
    oscTargetAddress = address;
    sender1.disconnect();
    sender1.connect(oscTargetAddress, oscTargetPort);
    std::cout << "Switched OSC target (from address change): " << oscTargetAddress << ":" << oscTargetPort << '\n';
}


juce::String  SeamLess_ClientAudioProcessor::getOscTargetAddress()
{
    return oscTargetAddress;
}


void SeamLess_ClientAudioProcessor::setOscTargetPort(int port)
{
    oscTargetPort = port;
    sender1.disconnect();
    sender1.connect(oscTargetAddress, oscTargetPort);
    std::cout << "Switched OSC target (from port change): " << oscTargetAddress << ":" << oscTargetPort << '\n';
}


int SeamLess_ClientAudioProcessor::getOscTargetPort()
{
    return oscTargetPort;
}

juce::AudioProcessorValueTreeState& SeamLess_ClientAudioProcessor::getState()
{
    return parameters;
}

bool SeamLess_ClientAudioProcessor::getSendState()
{
    return isSending;
}

void SeamLess_ClientAudioProcessor::setSendState(bool s)
{
    isSending=s;
}


void SeamLess_ClientAudioProcessor::parameterChanged(const juce::String & id, float val)
{
    // "Note that calling this method from within
    // AudioProcessorValueTreeState::Listener::parameterChanged()
    // is not guaranteed to return an up-to-date value for the parameter."

    //    if(id == "xPos")
    //        xPosSend(val);

    //    if(id == "yPos")
    //        yPosSend(val);

    //    if(id == "zPos")
    //        zPosSend(val);

    //    if(id=="sendGainWFS"||id=="sendGainHOA"||id=="sendGainREV"||id=="sendGainLFE")
    //        sendGainSend(id,val);
}


juce::AudioProcessor* JUCE_CALLTYPE createPluginFilter()
{
    return new SeamLess_ClientAudioProcessor();
}


void SeamLess_ClientAudioProcessor::hiResTimerCallback()
{
    if(isSending==true && playSending==true)
    {

        // xPosSend();
        // yPosSend();
        // zPosSend();

        xyzPosSend();

        sendGainSend();
    }
}

bool SeamLess_ClientAudioProcessor::getConnectedToMain()
{
  return connectedToMain;
}

void SeamLess_ClientAudioProcessor::setConnectedToMain(bool b)
{
    connectedToMain = b;
}
