/*
==============================================================================

SoundSource.cpp
Created: 15 Feb 2021 4:05:52pm
Author:  anwaldt

==============================================================================
*/

#include <JuceHeader.h>
#include "SoundSource.h"

//==============================================================================
SoundSource::SoundSource()
{

    // this makes the component ignore mouse events
    // and they reach the parent component
    setInterceptsMouseClicks(false,false);

}


SoundSource::~SoundSource()
{
}

void SoundSource::paint (juce::Graphics& g)
{
  //auto area = getLocalBounds().reduced (2);
  g.setColour (juce::Colours::lightblue);
  g.fillEllipse (xPos, yPos, width,height);
}

void SoundSource::resized ()
{

}


void SoundSource::mouseDown (const juce::MouseEvent& e)
{
}


void SoundSource::mouseDrag (const juce::MouseEvent& e)
{
}


void SoundSource::moveX(double x)
{
  setTopLeftPosition(x*10+300,this->getY());
}


void SoundSource::moveY(double y)
{
  setTopLeftPosition(this->getX(),y*10+400);
}


void SoundSource::moveXY(float x, float y)
{

    // repaint(xPos,yPos, 40,40);
    xPos = x*getWidth()  - (int) ((float) width/ 2.0);
    yPos = (1-y)*getHeight() - (int) ((float) height/2.0);

    // repaint(xPos,yPos, 40,40);
    repaint();

}


void SoundSource::moveXYZ(float x, float y, float z)
{

    // shift and enlarge area to repaint
    int shift = 5;
    int pad   = 10;

    // helper values for clearing the area at the old position
    // (maybe obsolete)
    int tmpWidth  = width;
    int tmpHeight = height;

    width  = 0;
    height = 0;

    repaint(xPos-shift,yPos-shift, tmpWidth+pad,tmpHeight+pad);


    xPos  = x*getWidth()      - (int) ((float) tmpWidth/ 2.0);
    yPos  = (1-y)*getHeight() - (int) ((float) tmpWidth/2.0);

    width  = 5+z*50;
    height = 5+z*50;

    // repaint(xPos,yPos, 40,40);
    repaint(xPos-shift,yPos-shift, width+pad,height+pad);

}
