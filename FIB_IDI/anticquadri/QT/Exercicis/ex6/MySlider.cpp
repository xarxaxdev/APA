#include "MySlider.h"

MySlider::MySlider(QWidget *parent):QSlider(parent) {

}

void MySlider::posaZero() {
  setSliderPosition(0);
}

