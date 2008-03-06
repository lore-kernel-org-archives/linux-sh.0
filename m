From: "Adrian McMenamin" <adrian@newgolddream.dyndns.info>
Date: Thu, 06 Mar 2008 17:51:12 +0000
Subject: Re: Behaviour of device_register
Message-Id: <29795.85.118.17.158.1204825872.squirrel@newgolddream.dyndns.info>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60803051525g3aca775dmc14d1c2450b34168@mail.gmail.com>
    <20080305234653.GA5904@kroah.com>
    <8031.85.118.17.158.1204806681.squirrel@newgolddream.dyndns.info>
    <20080306163032.GA12982@kroah.com>
In-Reply-To: <20080306163032.GA12982@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Adrian McMenamin <lkmladrian@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Thu, March 6, 2008 4:30 pm, Greg KH wrote:
> On Thu, Mar 06, 2008 at 12:31:21PM -0000, Adrian McMenamin wrote:
>> On Wed, March 5, 2008 11:46 pm, Greg KH wrote:
>> > On Wed, Mar 05, 2008 at 11:25:48PM +0000, Adrian McMenamin wrote:
>> >> The observed behaviour for me is that it appears to be blocking the
>> >> vblank interrupt on my box (or more accurately stopping the workqueue
>> >> that the interrupt handler calls from running). And without the
>> vblank
>> >> my bus won't process dma and so therefore the attempt to register the
>> >> device in question fails.
>> >>
>> >> But I can see no reason from a glance over the code why that (vblanks
>> >> being blocked) would be the case - have I missed something and the
>> >> vblanks will be blocked, or should I be looking elsewhere for the
>> root
>> >> cause of this problem?
>> >
>> > device_register(), on it's own, does not touch any hardware, nor
>> prevent
>> > anything else in the kernel from happening.
>> >
>> > So I think you need to look elsewhere, like into the bus that is doing
>> > the device_register() call :)
>> >
>>
>>
>> It turns out this is a lock contention issue.
>>
>> The code blocks waiting for a lock that will never be freed.
>
> The device_register() code blocks?  Or something else?
>

No my code. The hotplug event results in a message which is stored in a
linked list which is protected by a lock. To query the device I need to
queue a message in that linked list which is obviously locked. So
everything is timed out.

I need to make the device query asychronous from the hotplug. Not perfect,
but the only memory safe way of doing it I think.


