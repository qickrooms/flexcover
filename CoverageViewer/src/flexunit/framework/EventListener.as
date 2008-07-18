/*

Copyright (c) 2008. Adobe Systems Incorporated.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
  * Neither the name of Adobe Systems Incorporated nor the names of its
    contributors may be used to endorse or promote products derived from this
    software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

@ignore
*/

package flexunit.framework
{
   import flash.events.Event;
   
   import mx.collections.ArrayCollection;
   import mx.collections.ListCollectionView;
   
   /**
    * Listens for expected events, keeping track of the expected events that
    * actually occur. A helper class designed specifically for the 
    * <code>EventfulTestCase</code>.
    */ 
   internal class EventListener
   {
      //-------------------------------
      //
      // properties
      //
      //-------------------------------

      private var _expectedEventTypes : ListCollectionView = new ArrayCollection();
      
      private var _actualEvents : ListCollectionView = new ArrayCollection();
      
      /**
       * Gets a comma-separated string listing the types of events that were
       * expected.
       */ 
      public function get expectedEventTypes() : String
      {
         var eventTypes : String = "";

         for ( var i: uint; i < _expectedEventTypes.length; i++ )
         {
            eventTypes += _expectedEventTypes[ i ] as String; 

            if ( i < _expectedEventTypes.length - 1 )
            {
               eventTypes += ',';
            } 
         }
         
         return eventTypes;
      }

      /**
       * Gets a comma-separated string listing the types of events that have 
       * been heard.
       */ 
      public function get actualEventTypes() : String
      {
         var eventTypes : String = "";

         for ( var i: uint; i < _actualEvents.length; i++ )
         {
            var event : Event = _actualEvents[ i ] as Event;
            
            eventTypes += event.type;
            
            if ( i < _actualEvents.length - 1 )
            {
               eventTypes += ',';
            } 
         }
         
         return eventTypes;
      }
      
      /**
       * Gets an array of all the events that have been heard.
       */ 
      public function get actualEvents() : Array
      {
         return _actualEvents.toArray();
      }
      
      /**
       * Gets the last event to have been heard.
       */ 
      public function get lastActualEvent() : Event
      {
         if ( _actualEvents.length == 0 )
         {
            return null;
         }
         
         return Event( _actualEvents.getItemAt( _actualEvents.length - 1 ) );
      }
      
      //-------------------------------
      //
      // constructor
      //
      //-------------------------------

      public function EventListener()
      {
         _actualEvents = new ArrayCollection();
         _expectedEventTypes = new ArrayCollection();   
      }
      
      //-------------------------------
      //
      // functions
      //
      //-------------------------------

      /**
       * Records an expected event. 
       * 
       * @param type 
       *    the type of event expected
       */ 
      public function expectEvent( type : String ) : void
      {
         _expectedEventTypes.addItem( type );
      }
      
      /**
       * Verifies that the expected events were heard, returning 
       * <code>true</code> if so or <code>false</code> otherwise.
       */ 
      public function verifyExpectedEventsOccurred() : Boolean
      {
         if ( _expectedEventTypes.length != _actualEvents.length )
         {
            return false;
         } 
         
         for ( var i : uint = 0; i < _actualEvents.length; i++ )
         {
            if ( _expectedEventTypes[ i ] != Event( _actualEvents[ i ] ).type )
            {
               return false;
            }
         }
         
         return true;
      }

      /**
       * Handles an event by recording that it actually occurred.
       */ 
      public function handleEvent( event : Event ) : void
      {
         _actualEvents.addItem( event );
      }
   }
}