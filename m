From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 13 Feb 2013 06:59:56 +0000
Subject: Re: [PATCH 3/2] pinctrl: sh-pfc: fix a typo and simplify a definition on sh73a0
Message-Id: <Pine.LNX.4.64.1302130756520.18535@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1302121633000.7059@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1302121633000.7059@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

On Wed, 13 Feb 2013, Simon Horman wrote:

> [CC Linus and Laurent]
> 
> On Tue, Feb 12, 2013 at 04:34:31PM +0100, Guennadi Liakhovetski wrote:
> > Fix definition of the SDHIWP0 function and simplify the CPU_ALL_PORT
> > definition on sh73a0.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> This patch appears to be against code that has been merged into arm-soc
> for 3.9.
> 
> In particular the following change in the pfc branch of the renesas tree
> a.k.a the arm-soc/renesas/pinmux branch of the arm-soc tree.
> 
> commit 5d5166dc39bcbe2c21d4fca034540133c415dce6
> Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date:   Sat Dec 15 23:51:24 2012 +0100
> 
>     sh-pfc: Add sh73a0 pinmux support
>     
>     Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>     Acked-by: Paul Mundt <lethal@linux-sh.org>
>     Acked-by: Linus Walleij <linus.walleij@linaro.org>
>     Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> As such, I would like to handle it separately from the other two patches
> in this series which are against un-merged code.
> 
> Before I do so I would like to:
> 
> * Know about the severity of this problem.
>   Does it break things?

Yes, .dts doesn't compile without the semicolon.

> * Know what the author of the code, Laurent (CCed) thinks about this.

I thinik, you're the author. The semicolon disappears as a result of your 
merge, AFAICS both original conflicting patches were ok. However, I might 
easily have misinterpreted the merge history.

Thanks
Guennadi

> * Know what the pin control maintainer, Linus (CCed) thinks about this.
> 
>   Linus, I'm happy to handle this as its code that went through
>   my tree. Or I'm happy for you to take it. In the case of the former
>   an ack or otherwise would be appreciated.

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
