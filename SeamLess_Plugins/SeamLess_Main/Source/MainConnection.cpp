/*
  ==============================================================================

    Connection.cpp
    Created: 19 Mar 2021 2:52:36pm
    Author:  anwaldt

  ==============================================================================
*/

#include "MainConnection.h"


MainConnection::MainConnection(juce::WaitableEvent& stop_signal, SeamLess_MainAudioProcessor *p)
: InterprocessConnection(true, 15),
  stop_signal_(stop_signal)
{
    processor = p;
}

void MainConnection::connectionMade()
{

        std::cout << "Got connection from client!" << std::endl;

        // String msg("Stop talking!");
        // MemoryBlock mb(msg.toRawUTF8(), msg.length());
        // sendMessage(mb);
}

void MainConnection::connectionLost()
{
        printf("Connection to client lost\n");

        processor->removeClosedConnections();
}

void MainConnection::messageReceived(const juce::MemoryBlock& msg)
{
        // const auto str = msg.toString();
        // printf("From client: %s\n", str.toRawUTF8());
//
        // if (str.contains("713")) {
        // 	stop_signal_.signal();
        // }
}
