From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Feb 2010 01:03:09 +0000
Subject: Re: Problem when testing current git on sh3 + hp6xx
Message-Id: <20100224010309.GB17581@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100223025042.GA28763@rafazurita.homelinux.net>
In-Reply-To: <20100223025042.GA28763@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 23, 2010 at 07:38:03PM -0300, Rafael Ignacio Zurita wrote:
> On Tue, Feb 23, 2010 at 12:51:09PM +0900, Paul Mundt wrote:
> > Based on this it would seem that you are entering the kernel with pending
> > timer IRQs and are racing against the clockevent setup, as no one has set
> > up the event handler yet. Try this:
> 
> After to apply your patch it looks a lot better. The log :
> 
> Calibrating delay loop (skipped)... 22.11 BogoMIPS PRESET (lpjD220)

It would seem that the clock framework still needs a bit of work for this
CPU..

> HD64461 configured at 0xb0000000 on irq 36(mapped into 64 to 79)
> HD64461: enabling PCMCIA devices
[snip]
> scsi0 : pata_platform
> ata1: PATA max PIO0 mmio cmd 0x150001f0 ctl 0x150001fe irq 77

Good to see that sparseirq works as advertized here too.

> If your patch is applied then I need to check why X does not run, 
> but that is another story.
> If your patch is not going to mainline, then please, let me know
> what should be done to continue fixing the original issue.
> 
I'll push them out today and add your Tested-by. Thanks for testing!
