/*
  ==============================================================================

    TopView.cpp
    Created: 23 Mar 2021 2:23:16pm
    Author:  anwaldt

  ==============================================================================
*/

#include <JuceHeader.h>
#include "TopView.h"

//==============================================================================

TopView::TopView(SeamLess_ClientAudioProcessor *p): source()
{

    processor  = p;
    background = juce::ImageCache::getFromMemory (BinaryData::top_view_png, BinaryData::top_view_pngSize);

    addAndMakeVisible(source);
    startTimer(50);
}


TopView::~TopView()
{

}


void TopView::paint (juce::Graphics& g)
{
    g.setColour(juce::Colour (220,220,220));
    g.fillRoundedRectangle(0,0,getWidth(),getHeight(),30);

    g.setColour(seamlessBlue);
    g.drawRoundedRectangle(0,0,getWidth(),getHeight(),30,15);

    // g.drawImageAt(background.rescaled(700,400,juce::Graphics::mediumResamplingQuality), 0, 0);
}

void TopView::resized()
{
    source.setBounds(0,0,getWidth(),getHeight() );
}

void TopView::mouseDown(const juce::MouseEvent& e)
{
    changePosition(e.getPosition());
}


void TopView::mouseDrag (const juce::MouseEvent& e)
{
    changePosition(e.getPosition());
}

void TopView::changePosition(juce::Point <int> p)
{

    int x = p.getX();
    int y = p.getY()+0.5*getHeight();

    float xPos = -20*(0.5-(float) x / (float) getWidth());
    float yPos =  20*(0.5-(float) y / (float) getHeight())+10;

    processor->setXPos(xPos);
    processor->setYPos(yPos);
}


void TopView::mouseUp(const juce::MouseEvent& e)
{
}


void TopView::timerCallback()
{
    if(isUpdating == true)
    {
        /// @todo: scaling is hard coded
        float x = processor->getXPos() / 20.0 + 0.5;
        float y = processor->getYPos() / 20.0 + 0.5;
        float z = processor->getZPos() / 20.0 + 0.5;
        source.moveXYZ(x,y,z);
    }
}

