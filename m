From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Mar 2016 23:52:34 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <CANqRtoTJhEqZF9x27CgugcejD8V5bLENuK9nqnFknjmOnhEV0Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 25, 2016 at 7:00 AM, Rich Felker <dalias@libc.org> wrote:
> On Fri, Mar 25, 2016 at 06:18:56AM +0900, Magnus Damm wrote:
>> On Thu, Mar 24, 2016 at 6:01 PM, John Paul Adrian Glaubitz
>> <glaubitz@physik.fu-berlin.de> wrote:
>> > On 03/24/2016 09:50 AM, Magnus Damm wrote:
>> >> I recall hearing that Dreamcast hardware was historically used for
>> >> some SH development. Can't be that difficult to find such hardware,
>> >> however I highly doubt that the boot process is very convenient.
>> >> Hardware wise Dreamcast probably contains something like sh775x so it
>> >> should be similar to whatever is in QEMU.
>> >
>> > The Dreamcast has just 16 MiB of RAM. On the other hand, the LANDISK
>> > NAS device I have acquired for Rich in Japan comes with 64 MiB RAM
>> > and a SH7751 CPU running at 266 MHz. And people have used these devices
>> > in the past to run Debian.
>>
>> Indeed 64 MiB is better than 16MiB. It is also still simple to handle
>> from a software perspective with the fixed virtual-to-physical memory
>> windows used by the SH architecture. For more than 256 MiB of RAM some
>> 32-bit extensions were added, perhaps combined with the PMB hardware
>> unit unless I remember incorrectly. Those 32-bit extensions are not
>> available on older SoCs like sh7751 but on later generations like
>> sh7785 and probably sh7786 as well.
>
> I've been reading the documentation and trying to figure out the MMU
> and PMB stuff for SH4, and it seems the PMB is only relevant to
> extending the amount of virtual address space that can be remapped to
> different physical addresses, and only for kernelspace (userspace has
> no access to the P1 and P2 ranges it maps). The 32-bit physical memory
> extension is separate from what I can tell, and just uses the upper 3
> bits of the TLB registers which were previously reserved. Does this
> sound correct?

Sounds about right. It may be that the PMB is only used during early
boot to allow access of more than 29 bits of physical memory for
instance before the MMU is turned on. But depending on memory model
and protection requirements it may make sense to map in as much as
possible of lowmem into the virtual space using the PMB to take the
load of the MMU.

As you've figured out, the PMB hardware allows virtual -> physical
remapping of larger contiguous areas. It exist both for the SH CPU
core and also as part of various IOMMU variants. I believe the former
cannot generate any traps or interrupts while the latter is able to.
So no on-demand paging or other fancy stuff like protection that user
space would like to have.

/ magnus
