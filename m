From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 30 May 2012 08:05:18 +0000
Subject: Re: [PATCH][RFC] ARM: mach-shmobile: setup-sh7372: fixup chclr_offset base
Message-Id: <Pine.LNX.4.64.1205301002000.28640@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 30 May 2012, Kuninori Morimoto wrote:

> 
> Hi Guennadi
> 
> Thank you for your reply
> 
> > > In shdma.c, chclr_write() will use (chan_reg + chclr_offset).
> > > In sh7372 case, for example DMA0 case,
> > > DMA1CHCLR_0 is located on 0xfe008220,
> > > and chan_reg is started from 0xfe008020 (= sh7372_dmae0_resources).
> > > Thus, chclr_offset should be (0x220 - 0x20) instead of 0x220.
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Yes, your patch looks correct to me. One question: have you seen a runtime 
> > problem, that this patch fixes? CHCLR registers are written by the driver 
> > only upon controller reset in a loop over all channels under a 
> > spin_lock_irqsave(). With this bug CHCLR registers of the channels 0, 1, 
> > and 5 would be skipped, i.e., would not be properly resetted. Did you 
> > somehow observe this problem in your tests? Which tests have you done? If 
> > you couldn't do many, maybe I should run some more.
> > 
> > Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Thanks.
> But sorry. I didn't have any problem.
> I noticed it from source-code only, not board behavior.

Ok, but did you at least run some tests, where this code-path would be 
entered, including (runtime-) suspend and resume? If not yet, I think, it 
would be good to at least run a couple of short tests to make sure we're 
not causing any obvious regressions. I'll try to find some time later 
today or tomorrow for this.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
