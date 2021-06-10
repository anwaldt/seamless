/*
==============================================================================

SoundSource.h
Created: 15 Feb 2021 4:05:52pm
Author:  anwaldt

==============================================================================
*/

#pragma once

#include <JuceHeader.h>
#include "SeamLess_Client.h"

//==============================================================================
/*
*/
class SoundSource  : public juce::Component
{
public:

  SoundSource();

  ~SoundSource() override;

  void paint (juce::Graphics&);
  void resized();
  void mouseDown (const juce::MouseEvent& e);
  void mouseDrag (const juce::MouseEvent& e);
  void moveX(double x);
  void moveY(double y);

  /// moves the center of the elipse
  void moveXY(float x, float y);
  void moveXYZ(float x, float y, float z);

private:

  juce::ComponentBoundsConstrainer constrainer;
  juce::ComponentDragger dragger;

  int xPos = 0;
  int yPos = 0;

  int width  = 30;
  int height = 30;

  JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (SoundSource)
};
