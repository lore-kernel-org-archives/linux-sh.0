From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 May 2012 07:40:04 +0000
Subject: Re: [PATCH][RFC] ARM: mach-shmobile: setup-sh7372: fixup chclr_offset base
Message-Id: <87hauy2k33.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Guennadi

Thank you for your reply

> > In shdma.c, chclr_write() will use (chan_reg + chclr_offset).
> > In sh7372 case, for example DMA0 case,
> > DMA1CHCLR_0 is located on 0xfe008220,
> > and chan_reg is started from 0xfe008020 (= sh7372_dmae0_resources).
> > Thus, chclr_offset should be (0x220 - 0x20) instead of 0x220.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Yes, your patch looks correct to me. One question: have you seen a runtime 
> problem, that this patch fixes? CHCLR registers are written by the driver 
> only upon controller reset in a loop over all channels under a 
> spin_lock_irqsave(). With this bug CHCLR registers of the channels 0, 1, 
> and 5 would be skipped, i.e., would not be properly resetted. Did you 
> somehow observe this problem in your tests? Which tests have you done? If 
> you couldn't do many, maybe I should run some more.
> 
> Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks.
But sorry. I didn't have any problem.
I noticed it from source-code only, not board behavior.

Best regards
---
Kuninori Morimoto
