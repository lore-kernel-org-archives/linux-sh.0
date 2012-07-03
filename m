From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 03 Jul 2012 17:10:24 +0000
Subject: Re: Boot regression on Mackerel with current mainline
Message-Id: <201207031910.24864.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207031218.24797.rjw@sisk.pl> <Pine.LNX.4.64.1207031336320.29890@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207031336320.29890@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Thomas Gleixner <tglx@linutronix.de>

On Tuesday, July 03, 2012, Guennadi Liakhovetski wrote:
> Hi Rafael
> 
> On Tue, 3 Jul 2012, Rafael J. Wysocki wrote:
> 
> > Hi,
> > 
> > We seem to have a functional regression on Mackerel with 3.5-rc5 which
> > seems to be related to SDHI.  Namely, the SDHI driver appears to wait forever
> > for the devices to appear and commenting out all of the sdhi devices in the
> > board file works around the problem.
> > 
> > I can investigate some more later today if need be.
> 
> Have you checked the logs? Are you seeing any of these in the kernel log:
> 
> genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 

I see this only once per boot, but then sh_mobile_sdhi is saying "timeout
waiting for hardware interrupt" pretty much continuously.

> with an IRQ number at the end? If so, then this is a known problem, which 
> I'd hoped would have been long fixed by now:
> 
> https://lkml.org/lkml/2012/6/12/151
> 
> We can nommit a fix for it in mmc, or we can try to re-ping Thomas - if 
> this is indeed the bug, you're getting...

I guess it is, but having reviewed the above e-mail thread I don't think any
fix from Thomas is going to appear.  So, please fix that in MMC, if possible.

Thanks,
Rafael
