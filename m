From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 23 May 2014 11:31:43 +0000
Subject: Re: R-CAR's arch
Message-Id: <537F319F.7010209@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140522101938.51fec16f@endymion.delvare>
In-Reply-To: <20140522101938.51fec16f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 05/23/2014 12:23 PM, Jean Delvare wrote:

>> Hi Jean,

>> On Thursday 22 May 2014 10:19:38 Jean Delvare wrote:
>>> Hi Simon and all,

>>> I am in the process of cleaning up dependencies for hardware-specific
>>> linux drivers. I'm looking into R-CAR drivers now and I have to admit I
>>> am confused. Some drivers (drm, gpio) depend on ARM, some (i2c, gen2
>>> pci, thermal, sata) depend on ARCH_SHMOBILE, sound depends on SUPERH ||
>>> ARCH_SHMOBILE, gen2 usb depends on ARCH_R8A7790 || ARCH_R8A7791, while
>>> gen1 usb and video-in have no architecture/platform dependency at all.

>>> Shouldn't all these drivers have the same architecture/platform
>>> dependency? If so, what would the correct one be?

>>> I admit I don't really understand how SHMOBILE relates to ARM and
>>> SUPERH (which so far I thought were two different and totally
>>> independent architectures, but apparently I was wrong?)

>> CONFIG_SUPERH is defined for arch/sh only, and CONFIG_ARCH_SHMOBILE for
>> arch/arm/mach-shmobile.

>> The Kconfig dependencies for Renesas drivers currently model two different
>> things, which are what the driver requires in order to compile and which
>> architecture(s) the driver can run on.

>> There's no question regarding the former. If a driver can only be compiled on
>> arch/sh it must list CONFIG_SUPERH as a dependency. Ditto for CONFIG_ARM or
>> CONFIG_ARCH_SHMOBILE. However, this should be a pretty uncommon case, as most
>> drivers should have no compile dependency on a specific architecture (the
>> exception here is when a driver uses an API not available on all architectures
>> for which no specific Kconfig symbol exists).

> Yes, I am aware of and agree on that.

>> The latter is more debatable. We've started by listing platforms on which the
>> hardware is known to exist as dependencies to avoid cluttering the kernel
>> configuration with useless options. However, this excludes drivers for
>> automated builds that can be very useful to report compilation bugs early.
>> We've thus started moving to adding a || COMPILE_TEST dependency to enable
>> driver compilation even on architectures where the device isn't available
>> (only when the driver is expected to compile properly of course).

>> We've decided to split dependencies on two (or more) lines, one for the
>> runtime dependencies and one or more for the compile time dependencies. A good
>> example of that is the SPI MSIOF driver.

>> config SPI_SH_MSIOF
>>          tristate "SuperH MSIOF SPI controller"
>>          depends on HAVE_CLK
>>          depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>>          help
>>            SPI driver for SuperH and SH Mobile MSIOF blocks.

>> The first "depends on" line states that the driver requires the clock API to
>> compile, and the second line states that the device is available on SUPERH and
>> ARCH_SHMOBILE only, but can be compiled on other architectures when
>> COMPILE_TEST is enabled.

>> I'd like to generalize this pattern, please feel free to help :-)

> This is an interesting approach, I like it. I'll stick to it for my
> future patches, starting with CONFIG_USB_RCAR_PHY and
> CONFIG_VIDEO_RCAR_VIN.

> For USB PHY the dependencies are clear.

    Do you mean ARCH_MOBILE || COMPILE_TEST? Actually, looking at generation 2 
PHY entry, ARCH_R8A7778 || ARCH_R8A7779 probably makes more sense.

> For VIN I'm not so sure, does
> anybody know? I'd got for ARCH_SHMOBILE || COMPILE_TEST but I don't know
> if SUPERH should be listed too.

    TTBOMK, no. VIN has been first encountered on ARCH_SMOBILE.

> Thanks,

WBR, Sergei

