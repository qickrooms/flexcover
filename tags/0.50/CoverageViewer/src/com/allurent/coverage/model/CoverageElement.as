/* 
 * Copyright (c) 2008 Allurent, Inc.
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
package com.allurent.coverage.model
{
    import flash.events.EventDispatcher;
    
    /**
     * Represents a single element of coverage as recorded by the instrumented application,
     * or present in coverage metadata generated by the compiler.
     */
    public class CoverageElement extends EventDispatcher
    {
        public var className:String;
        public var packageName:String;
        public var functionName:String;
        public var pathname:String;  // This is optional
        
        /**
         * Get a "path" of names that can be used to resolve a LineModel for this CoverageElement
         * within the model. 
         */
        public function get path():Array
        {
            return null;
        }
        
        /**
         * Construct a CoverageElement from an instrumentation or metadata string of this form:
         * 
         *    <package> ":" <class> "/" <function> "@" [ <line> | ("+" | "-") <line> ":" <column> ]
         * 
         * Note that <function> may itself contain slashes for getter and setter suffixes of
         * "/get" and "/set" respectively.
         * 
         */
        public static function fromString(s:String):CoverageElement
        {
            var packageName:String;
            var className:String;
            var functionName:String;
            var pathname:String;
            
            var firstSemi:int = s.indexOf(";");
            if (firstSemi >= 0)
            {
                pathname = s.substring(firstSemi+1);
                s = s.substring(0, firstSemi);
            }
            
            var firstSlash:int = s.indexOf("/");
            if (firstSlash < 0)
            {
                return null;
            }
            else
            {
                var fullClass:String = s.substring(0, firstSlash);
                var colon:int = fullClass.indexOf(":");
                if (colon < 0)
                { 
                    className = fullClass;
                    packageName = "";
                }
                else
                {
                    packageName = fullClass.substring(0, colon);
                    className = fullClass.substring(colon+1);
                }
            }
            var lastAt:int = s.lastIndexOf("@");
            if (lastAt < 0)
            {
                return null;
            }

            var location:String = s.substring(lastAt+1); 
            functionName = s.substring(firstSlash+1, lastAt);

            // For some reason this gets stuck in by the compiler.
            if (functionName.substring(0, 8) == "private:")
            {
                functionName = functionName.substring(8);
            }
            else if (functionName.substring(0, 10) == "protected:")
            {
                functionName = functionName.substring(10);
            }

            if (location.charAt(0) == "+" || location.charAt(0) == '-')
            {
                var bce:BranchCoverageElement = new BranchCoverageElement();
                bce.className = className;
                bce.packageName = packageName;
                bce.functionName = functionName;
                bce.pathname = pathname;
                bce.location = location;
                return bce;
            }
            else
            {
                var lce:LineCoverageElement = new LineCoverageElement();
                lce.className = className;
                lce.packageName = packageName;
                lce.functionName = functionName;
                lce.pathname = pathname;
                lce.line = parseInt(location);
                return lce;
            }
        }
    }
}