From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 07 Mar 2009 06:20:14 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <20090307062014.GC14735@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2009 at 06:29:51PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:05 Fri 06 Mar     , Francesco VIRLINZI wrote:
> > Hi Magnus
> >>
> >> Great! You should try in on some ST hardware as well. =)
> >>   
> > Yes I could try if it works also if we already had the hibernation on  
> > memory on sh4.
> >>   
> >>> Is it also for sh4 with PMB? If so how are you managing the PMB?
> >>> Moreover what about interrupt controller? This means after a resume from
> >>> hibernation
> >>> you could have a resumed device (and driver) but the interrupt controller
> >>> has the right irq-line not initialized.
> >>>     
> >>
> >> I have not tested with PMB.
> > On PMB: some entries may be is already OK (the entries the bootloader  
> > prepared fot linux)
> > but Linux has to force an hw-initialization of the other entries
> the memory init will be done by u-boot so PMB will not be a problem
> the other device could be init by u-boot with a different stat than the kernel
> expect, so each device will have to check its state and re-init in the good
> state

u-boot knows nothing about the PMB, and even if it did, the best it could
do is set up fixed entries for P1/P2 identity mapping and so on. If
u-boot started playing with the PMB, the first thing we would do in the
kernel would be to blow away all of the u-boot mappings and replace them
with something we can trust. The same applies to the TLB, although we
don't have to be as careful there when flushing.

The issue is not with the fixed mappings that are established at boot,
but the additional mappings that are created dynamically. As PMB entries
are not faulted, we can't simply depend on the TLB miss to take care of
re-establishing the mappings. Any sort of device with lazy initialization
or dynamic state that is not restored in the boot path needs to be
written out to the suspend image.
