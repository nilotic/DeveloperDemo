//
//  ColorPickerWebData.swift
//
//  Created by Den on 8/6/26.
//  Copyright © nilotic. All rights reserved.
//

import Foundation

struct ColorPickerWebData {
    let htmlString = """
                    <!DOCTYPE html>
                    <html>
                    <head>
                      <meta charset="UTF-8">
                      <title>P3 Color Picker</title>
                      <style>
                        input[type="color"] {
                          -webkit-appearance: none;
                          width: 260pt;
                          height: 260pt;
                        }
                        
                        .color-picker-container {
                          display: flex;
                          align-items: center;
                          overflow-x: auto;
                          white-space: nowrap;
                        }
                        
                        .color-picker-container > div:first-child {
                          padding-left: 30pt;
                        }
                        
                        .color-picker-container > div:last-child {
                          padding-right: 30pt;
                        }
                        
                        .color-info {
                          margin-top: 20pt;
                          margin-bottom: 60pt;
                          align-items: center;
                          font-family: Arial, sans-serif;
                          font-size: 24pt;
                          text-align: center;
                        }
                      </style>
                    </head>
                    <body>
                      <div class="color-picker-container">
                        <div>
                          <input type="color" id="colorPicker1" value="#690085" oninput="updateColor(this.value, 'colorInfo1')">
                          <div class="color-info" id="colorInfo1">Hex: #690085<br>RGB: (105, 0, 133)</div>
                        </div>
                        <div>
                          <input type="color" id="colorPicker2" value="#E2B3FF" oninput="updateColor(this.value, 'colorInfo2')">
                          <div class="color-info" id="colorInfo2">Hex: #E2B3FF<br>RGB: (226, 179, 255)</div>
                        </div>
                        <div>
                          <input type="color" id="colorPicker3" value="#FF5A1E" oninput="updateColor(this.value, 'colorInfo3')">
                          <div class="color-info" id="colorInfo3">Hex: #FF5A1E<br>RGB: (255, 90, 30)</div>
                        </div>
                        <div>
                          <input type="color" id="colorPicker4" value="#FFBFAB" oninput="updateColor(this.value, 'colorInfo4')">
                          <div class="color-info" id="colorInfo4">Hex: #FFBFAB<br>RGB: (255, 191, 171)</div>
                        </div>
                        <div>
                          <input type="color" id="colorPicker5" value="#333333" oninput="updateColor(this.value, 'colorInfo5')">
                          <div class="color-info" id="colorInfo5">Hex: #333333<br>RGB: (51, 51, 51)</div>
                        </div>
                        <div>
                          <input type="color" id="colorPicker6" value="#ECF0F2" oninput="updateColor(this.value, 'colorInfo6')">
                          <div class="color-info" id="colorInfo6">Hex: #ECF0F2<br>RGB: (236, 240, 242)</div>
                        </div>
                      </div>
                      <script>
                        function updateColor(color, infoId) {
                          var hexColor = color.toUpperCase();
                          var rgbColor = hexToRgb(hexColor);
                          
                          var colorInfo = document.getElementById(infoId);
                          colorInfo.innerHTML = "Hex: " + hexColor + "<br>RGB: " + rgbColor;
                        }
                        
                        function hexToRgb(hex) {
                          var shorthandRegex = /^#?([a-f\\d])([a-f\\d])([a-f\\d])$/i;
                          hex = hex.replace(shorthandRegex, function(m, r, g, b) {
                            return r + r + g + g + b + b;
                          });
                          
                          var result = /^#?([a-f\\d]{2})([a-f\\d]{2})([a-f\\d]{2})$/i.exec(hex);
                          var r = parseInt(result[1], 16);
                          var g = parseInt(result[2], 16);
                          var b = parseInt(result[3], 16);
                          
                          return "(" + r + ", " + g + ", " + b + ")";
                        }
                      </script>
                    </body>
                    </html>
                    """
}

#if DEBUG
extension ColorPickerWebData {
    
    static var placeholder: ColorPickerWebData {
        ColorPickerWebData()
    }
}
#endif
