From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 23 Apr 2010 07:26:35 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <20100423072635.GA11770@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 23, 2010 at 03:25:12PM +0900, Alexandre Courbot wrote:
> > One noticeable difference for sh-bios users in sh-sci is the
> > detach callback via sh_bios_gdb_detach(), you might want to try
> > commenting this out to make sure you're not trapping in to some bogus
> > location.
> 
> > If the sh-bios earlyprintk is working for you then you might
> > also try the 'keep' option to prevent the serial console from taking
> > control away from it.
> 
> Indeed, that workarounds the problem, but then I stop getting feedback
> from the kernel starting from when init is supposed to start:
> 
> VFS: Mounted root (nfs filesystem) on device 0:12.
> Freeing unused kernel memory: 184k freed
> 
That would be because the early consoles themselves are only meant for
debugging aids, and have no input methods of their own. With no backing
device userspace will also fail to bind /dev/console, so this is the
expected behaviour.

> Still, it would be nice to get the SCIF to work on that platform. I'm
> willing to investigate the problem (may be clock-related indeed), but
> could someone provide me some guidance about where in the driver I
> should look at?
> 
I've dusted off the SH7780 Highlander to see if there were any immediate
issues with the clock or serial code that would have broken the CPU, but
that all worked out of the box.

> Thanks again, looks like I'm close to having a working kernel again!

The obvious remaining question would be are you sure that your serial
port is really on ttySC1? Most of the SH7780 boards placed the console on
ttySC0 by default, so make sure that you aren't just being bitten by a
bogus defconfig setting.

If you have board support patches that you've applied to the kernel then
you might also want to try backing those off and simply booting with the
default machvec with SH7780 support enabled. Given that the serial port
is an SoC property you shouldn't have any difficulty getting a console
even if you have no other board support built in.

You may also want to disable sh-bios support in the off chance that this
is clobbering something it shouldn't be (note that sh-bios support itself
is almost never tested these days, and in the past it has always been a
source of inconsistency).

If all else fails then we'll simply have to debug the init path, but I
suspect you're being bitten by something completely unrelated given that
none of the other SH7780's exhibit any sort of difficulty.
