From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Feb 2013 00:58:20 +0000
Subject: Re: [PATCH 3/2] pinctrl: sh-pfc: fix a typo and simplify a definition on sh73a0
Message-Id: <20130214005820.GG15879@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1302121633000.7059@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1302121633000.7059@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 13, 2013 at 06:48:24PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 13 February 2013 17:53:34 Simon Horman wrote:
> > On Wed, Feb 13, 2013 at 08:02:56AM +0100, Guennadi Liakhovetski wrote:
> > > On Wed, 13 Feb 2013, Guennadi Liakhovetski wrote:
> > > > On Wed, 13 Feb 2013, Simon Horman wrote:
> > > > > On Tue, Feb 12, 2013 at 04:34:31PM +0100, Guennadi Liakhovetski wrote:
> > > > > > Fix definition of the SDHIWP0 function and simplify the CPU_ALL_PORT
> > > > > > definition on sh73a0.
> > > > > > 
> > > > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > > > 
> > > > > This patch appears to be against code that has been merged into
> > > > > arm-soc for 3.9.
> > > > > 
> > > > > In particular the following change in the pfc branch of the renesas
> > > > > tree a.k.a the arm-soc/renesas/pinmux branch of the arm-soc tree.
> > > > > 
> > > > > commit 5d5166dc39bcbe2c21d4fca034540133c415dce6
> > > > > Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > > Date:   Sat Dec 15 23:51:24 2012 +0100
> > > > > 
> > > > >     sh-pfc: Add sh73a0 pinmux support
> > > > >     
> > > > >     Signed-off-by: Laurent Pinchart
> > > > >     <laurent.pinchart+renesas@ideasonboard.com>
> > > > >     Acked-by: Paul Mundt <lethal@linux-sh.org>
> > > > >     Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > >     Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > > 
> > > > > As such, I would like to handle it separately from the other two
> > > > > patches in this series which are against un-merged code.
> > > > > 
> > > > > Before I do so I would like to:
> > > > > 
> > > > > * Know about the severity of this problem.
> > > > > 
> > > > >   Does it break things?
> > > > 
> > > > Yes, .dts doesn't compile without the semicolon.
> > > 
> > > Ok, sorry, obviously, I was thinking about a different patch. Please,
> > > ignore this.
> > > 
> > > As for breakage - so far I'm personally unaware of any breakage, which is
> > > of course not to say, that none is possible.
> > 
> > Thanks. In any case it is probably appropriate for v3.10.
> > In any case I'll wait to see what Laurent and Linus have to say.
> 
> Patches 1/2 should be squashed into the merge that introduced the issue (I 
> think that's what you've done already) and 2/2 should be carried along with 
> your other kzm9g-reference pinctrl patches for now.

Yes, that is what I have done.

> I've taken patch 3/2 in my tree. Given the the SDHIWP0_PU function GPIO
> isn't used in mainline I don't think there's a need to fast-track it to
> v3.9, I will include it in my next pinctrl series for v3.10.

Great, thanks.
