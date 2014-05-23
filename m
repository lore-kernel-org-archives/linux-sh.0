From: Simon Horman <horms@verge.net.au>
Date: Fri, 23 May 2014 00:37:12 +0000
Subject: Re: R-CAR's arch
Message-Id: <20140523003709.GA8483@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140522101938.51fec16f@endymion.delvare>
In-Reply-To: <20140522101938.51fec16f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 23, 2014 at 12:55:07AM +0200, Laurent Pinchart wrote:
> Hi Jean,
> 
> On Thursday 22 May 2014 10:19:38 Jean Delvare wrote:
> > Hi Simon and all,
> > 
> > I am in the process of cleaning up dependencies for hardware-specific
> > linux drivers. I'm looking into R-CAR drivers now and I have to admit I
> > am confused. Some drivers (drm, gpio) depend on ARM, some (i2c, gen2
> > pci, thermal, sata) depend on ARCH_SHMOBILE, sound depends on SUPERH ||
> > ARCH_SHMOBILE, gen2 usb depends on ARCH_R8A7790 || ARCH_R8A7791, while
> > gen1 usb and video-in have no architecture/platform dependency at all.
> > 
> > Shouldn't all these drivers have the same architecture/platform
> > dependency? If so, what would the correct one be?
> > 
> > I admit I don't really understand how SHMOBILE relates to ARM and
> > SUPERH (which so far I thought were two different and totally
> > independent architectures, but apparently I was wrong?)
> 
> CONFIG_SUPERH is defined for arch/sh only, and CONFIG_ARCH_SHMOBILE for 
> arch/arm/mach-shmobile.

For Jean's benefit:

SUPERH is an architecture.
SHMOBILE is the in-kernel name for ARM based SoCs from Renesas.

Some IP blocks are shared between both.
Or more to the point SHMOBILE makes use of some (e.g. driver)
code that was originally developed for use with SUPERH.

> The Kconfig dependencies for Renesas drivers currently model two different 
> things, which are what the driver requires in order to compile and which 
> architecture(s) the driver can run on.
> 
> There's no question regarding the former. If a driver can only be compiled on 
> arch/sh it must list CONFIG_SUPERH as a dependency. Ditto for CONFIG_ARM or 
> CONFIG_ARCH_SHMOBILE. However, this should be a pretty uncommon case, as most 
> drivers should have no compile dependency on a specific architecture (the 
> exception here is when a driver uses an API not available on all architectures 
> for which no specific Kconfig symbol exists).
> 
> The latter is more debatable. We've started by listing platforms on which the 
> hardware is known to exist as dependencies to avoid cluttering the kernel 
> configuration with useless options. However, this excludes drivers for 
> automated builds that can be very useful to report compilation bugs early. 
> We've thus started moving to adding a || COMPILE_TEST dependency to enable 
> driver compilation even on architectures where the device isn't available 
> (only when the driver is expected to compile properly of course).
> 
> We've decided to split dependencies on two (or more) lines, one for the 
> runtime dependencies and one or more for the compile time dependencies. A good 
> example of that is the SPI MSIOF driver.
> 
> config SPI_SH_MSIOF
>         tristate "SuperH MSIOF SPI controller"
>         depends on HAVE_CLK
>         depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>         help
>           SPI driver for SuperH and SH Mobile MSIOF blocks.
> 
> The first "depends on" line states that the driver requires the clock API to 
> compile, and the second line states that the device is available on SUPERH and 
> ARCH_SHMOBILE only, but can be compiled on other architectures when 
> COMPILE_TEST is enabled.
> 
> I'd like to generalize this pattern, please feel free to help :-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
