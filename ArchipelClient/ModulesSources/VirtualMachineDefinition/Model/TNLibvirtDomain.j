/*  
 * TNLibvirtDomain.j
 *    
 * Copyright (C) 2010 Antoine Mercadal <antoine.mercadal@inframonde.eu>
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 * 
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

@import <Foundation/Foundation.j>
@import <StropheCappuccino/TNXMLNode.j>

@import "TNLibvirtBase.j";


@implementation TNLibvirtDomain : TNLibvirtBase
{
    CPString                _bootloader         @accessors(property=bootloader);
    CPString                _description        @accessors(property=description);
    CPString                _domainType         @accessors(property=domainType);
    CPString                _name               @accessors(property=name);
    CPString                _onCrash            @accessors(property=onCrash);
    CPString                _onPowerOff         @accessors(property=onPowerOff);
    CPString                _onReboot           @accessors(property=onReboot);
    CPString                _UUID               @accessors(property=UUID);
    int                     _currentMemory      @accessors(property=currentMemory);
    int                     _memory             @accessors(property=memory);
    int                     _vcpu               @accessors(property=VCPU);
    TNLibvirtDomainBlockIOTune      _blkiotune          @accessors(property=blkiotune);
    TNLibvirtDomainClock          _clock              @accessors(property=clock);
    TNLibvirtDevices        _devices            @accessors(property=devices);
    TNLibvirtDomainFeatures       _features           @accessors(property=features);
    TNLibvirtDomainMemoryBacking  _memoryBacking      @accessors(property=memoryBacking);
    TNLibvirtDomainMemoryTune        _memoryTuning       @accessors(property=memoryTuning);
    TNLibvirtDomainOS             _OS                 @accessors(property=OS);

}

- (TNXMLNode)XMLNode
{
    if (!_domainType)
        [CPException raise:@"Missing domainType" reason:@"domainType is required"];

    var node = [TNXMLNode nodeWithName:@"domain" andAttributes:{@"type":_domainType}];
    
    if (_name)
    {
        [node addChildWithName:@"name"];
        [node addTextNode:_name];
        [node up];
    }
    if (_UUID)
    {
        [node addChildWithName:@"uuid"];
        [node addTextNode:_UUID];
        [node up];
    }
    if (_memory)
    {
        [node addChildWithName:@"memory"];
        [node addTextNode:[_memory stringValue]];
        [node up];
    }
    if (_currentMemory)
    {
        [node addChildWithName:@"currentMemory"];
        [node addTextNode:[_currentMemory stringValue]];
        [node up];
    }
    if (_vcpu)
    {
        [node addChildWithName:@"vcpu"];
        [node addTextNode:[_vcpu stringValue]];
        [node up];
    }
    if (_bootloader)
    {
        [node addChildWithName:@"bootloader"];
        [node addTextNode:_bootloader];
        [node up];
    }
    if (_OS)
    {
        [node addNode:[_OS XMLNode]];
        [node up];
    }
    if (_clock)
    {
        [node addNode:[_clock XMLNode]];
        [node up];
    }
    if (_onPowerOff)
    {
        [node addChildWithName:@"on_poweroff"];
        [node addTextNode:_onPowerOff];
        [node up];
    }
    if (_onReboot)
    {
        [node addChildWithName:@"on_reboot"];
        [node addTextNode:_onReboot];
        [node up];
    }
    if (_onCrash)
    {
        [node addChildWithName:@"on_crash"];
        [node addTextNode:_onCrash];
        [node up];
    }
    if (_features)
    {
        [node addNode:[_features XMLNode]];
        [node up];
    }
    if (_memoryBacking)
    {
        [node addNode:[_memoryBacking XMLNode]];
        [node up];
    }
    if (_blkiotune)
    {
        [node addNode:[_blkiotune XMLNode]];
        [node up];
    }
    if (_devices)
    {
        [node addNode:[_devices XMLNode]];
        [node up];
    }
    
    return node;
}

@end