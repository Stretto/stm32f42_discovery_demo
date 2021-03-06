// Copyright © 2015 Michael V. Franklin
//      
// This file is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this file.  If not, see <http://www.gnu.org/licenses/>.

module board.lcd;

import gcc.attribute;

import ILI9341 = board.ILI9341;
import ltdc = board.ltdc;
import trace = stm32f42.trace;

package void init()
{
	ILI9341.init();
	ltdc.init();
}

@inline public uint getWidth()
{
	return ltdc.getWidth();
}

@inline public uint getHeight()
{
	return ltdc.getHeight();
}

private int clamp(int value, int min, int max)
{
	if (value < min)
	{
		return min;
	}
	else if (value > max)
	{
		return max;
	}
	
	return value;
}

public void fillRect(int x, int y, uint width, uint height, ushort color)
{
	int x2 = x + width;
	int y2 = y + height;
	x = clamp(x, 0, getWidth() - 1);
	y = clamp(y, 0, getHeight() - 1);
	x2 = clamp(x2, 0, getWidth() - 1);
	y2 = clamp(y2, 0, getHeight() - 1);
	width = x2 - x + 1;
	for(int _y = y; _y <= y2; _y++)
	{
		ltdc.fillSpan(x, _y, width, color);
	}
}
