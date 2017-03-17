package com.thunder.events
{
   import flash.events.Event;
   
   public class ButtonEvent extends Event
   {
      
      public static const BTN_PRESS:String = "button_press";
      public static const BTN_RELEASE:String = "button_release";
      
      public var value;
      
      public function ButtonEvent(param1:String)
      {
         super(param1);
      }
   }
}
