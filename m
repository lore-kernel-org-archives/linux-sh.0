From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 20 Dec 2008 22:17:25 +0000
Subject: Re: [PATCH] sh: maple: add support for Maple controller as a joystick
Message-Id: <11B1B6AB-D879-4BB9-AE05-C5025B449CA1@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1229728542.1441.6.camel@localhost.localdomain> <20081220151511.GA6528@console-pimps.org> <1229789248.6502.4.camel@localhost.localdomain> <200812201219.12511.dmitry.torokhov@gmail.com> <1229806020.6502.35.camel@localhost.localdomain>
In-Reply-To: <1229806020.6502.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Matt Fleming <matt@console-pimps.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>

On Dec 20, 2008, at 12:47 PM, Adrian McMenamin <adrian@newgolddream.dyndns.info 
 > wrote:

> On Sat, 2008-12-20 at 12:19 -0800, Dmitry Torokhov wrote:
>> On Saturday 20 December 2008 08:07:27 Adrian McMenamin wrote:
>>> On Sat, 2008-12-20 at 15:16 +0000, Matt Fleming wrote:
>>>> On Fri, Dec 19, 2008 at 11:15:42PM +0000, Adrian McMenamin wrote:
>>>>> Add support for the SEGA Dreamcast Maple controller as a joystick
>>>>
>>>> [snip]
>>>>
>>>>> +    struct dc_pad *pad = maple_get_drvdata(mapledev);
>>>>> +    struct input_dev *dev = pad->dev;
>>>>> +    unsigned char *res = mq->recvbuf;
>>>>> +
>>>>> +    buttons = ~cpu_to_le16(*(unsigned short *)(res + 8));
>>>>> +
>>>>
>>>> I may be wrong but shouldn't this use the I/O accessor functions?
>>>
>>> It's not iomemory, so I don't think so. The maple bus writes to a  
>>> buffer
>>> in the physical RAM.
>>>
>>
>> Hmm, but why we are going _from_ cpu order to le16??? I'd expect we
>> wanted to do conversion the other way around. I pulled it out of  
>> 'next'
>> for now.
>>
> The data is transmitted here by the bus in 32 bit little endian blocks
> but makes sense in le16 bit lumps. Off is 1 and on is 0 - hence the ~
>
> The first 16 bits are the button data the next 16 bits are the (start
> of) the axis data. Both cpu and bus data (in this case - it can vary)
> are little endian.

Right, so I think we need le16_to_cpu here, you want the data in  
native CPU order to manipulate it.

-- 
Dmitry

