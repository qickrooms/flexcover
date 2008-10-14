/* 
 * Copyright (c) 2008 Adobe Systems Incorporated.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
 * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package com.adobe.ac.util.service
{
	import flash.events.Event;
	
	import flexunit.framework.Assert;

	public class LocalConnectionMock implements ILocalConnection
	{
		//used in send and connect
        public var expectedConnectionName:String;
        public var actualConnectionName:String;
		
		//used in send
        public var expectedMethodName:String;
        public var actualMethodName:String;        
        public var expectedParameter1:Object;
        public var actualParameter1:Object;        
        
        private var localConnectionName:String;
        
        public function LocalConnectionMock(localConnectionName:String=null)
        {
        	this.localConnectionName = localConnectionName;
        }
        
		public function verify():void
		{
			Assert.assertEquals("differnt connectionName in "+localConnectionName, 
			                     expectedConnectionName, actualConnectionName);
			Assert.assertEquals("differnt methodName in "+localConnectionName, 
			                     expectedMethodName, actualMethodName);
			Assert.assertEquals("differnt parameter 1 in "+localConnectionName, 
			                     expectedParameter1, actualParameter1);
		}
        
		public function send(connectionName:String, methodName:String, ...parameters):void
		{
			actualConnectionName = connectionName;
			actualMethodName = methodName;
			actualParameter1 = (parameters.length > 0) ? parameters[0] : null;
		}
		
		public function set client(value:Object):void
		{
		}
		
		public function allowDomain(...domains):void
		{
		}
		
		public function connect(connectionName:String):void
		{
			actualConnectionName = connectionName;
		}
		
		public function close():void
		{
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return false;
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return false;
		}
		
		public function willTrigger(type:String):Boolean
		{
			return false;
		}
		
	}
}