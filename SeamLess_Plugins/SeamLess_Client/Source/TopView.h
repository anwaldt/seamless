/*
  ==============================================================================

    TopView.h
    Created: 23 Mar 2021 2:23:16pm
    Author:  anwaldt

  ==============================================================================
*/

#pragma once

class SoundSource;

#include <JuceHeader.h>
#include "../JuceLibraryCode/JuceHeader.h"
#include "PluginProcessor.h"

#include "SoundSource.h"

//==============================================================================
/*
*/
class TopView  : public juce::Component, juce::Timer
{
public:
    TopView(SeamLess_ClientAudioProcessor *p);
    ~TopView() override;

    void paint (juce::Graphics&) override;
    void resized() override;

    /// \brief mouseDown
    /// \param e
    ///
    /// Calls changePosition() when the mouse is dragged.
    void mouseDown(const juce::MouseEvent& e);

    /// \brief mouseDrag
    /// \param e
    ///
    /// Calls changePosition() when the mouse is dragged.
    void mouseDrag(const juce::MouseEvent& e);

    /// \brief changePosition
    /// \param p
    /// Sets the X and Y position parameters of the
    /// processor.
    void changePosition(juce::Point <int> p);

    void mouseUp(const juce::MouseEvent& e);


private:

    SeamLess_ClientAudioProcessor *processor;
    SoundSource source;

    juce::Image background;

    juce::ComponentDragger dragger;

    bool isUpdating = true;

    ///
    /// \brief timerCallback
    /// set source position
    /// scaled between 0 and 1
    virtual void timerCallback();

    JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (TopView)

};
