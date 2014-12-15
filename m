From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 15 Dec 2014 06:55:06 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141215064306.GN16827@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <2462101.Er8OZg9N24@avalon>
 <20141211214732.GC21482@katana>
 <1729516.HWbfnj3Cpn@avalon>
In-Reply-To: <1729516.HWbfnj3Cpn@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Dec 11, 2014 at 11:52:10PM +0200, Laurent Pinchart wrote:
> On Thursday 11 December 2014 22:47:32 Wolfram Sang wrote:
> > > > Note that the I2C drives uses subsys_initcall() for historic reasons,
> > > > while the DMA driver uses module_init(). This is hard to revert without
> > > > introducing potential regressions on older boards. So, the I2C DMA
> > > > support needs to handle deferred probe definately. I am with Laurent, I
> > > > don't see any other way, but I'd be glad to be enlightened...
> > > 
> > > While I believe that requesting the channel at transfer time is the good
> > > solution, I think we should still try to move to module initcalls where
> > > possible. The risk of regressions is real so proper testing is needed. My
> > > question is, have you tried it ?
> > 
> > I would need to test all boards using this driver to not fail booting.
> > Usually I2C drivers are moved to subsys_initcall because they need
> > access to something critical (PMIC, GPIOs...) early. I don't see a sane
> > way to do that testing.
> 
> Still, I would like to get a better view on the problems we should expect, by 
> testing this on the latest boards for instance.
> 
> > Other than that, even if we move to module_init, we reduce the chance of
> > getting a deferred probe, but we do not eliminate it...
> 
> Sure, but reducing the chance of deferred probe is a good idea in my opinion 
> :-)
Okay so what is the issue here, this statement is a bit worrying. Why do
you guys want to reduce the chance of deferred probe? I assumed that issue was
the channels availability...

-- 
~Vinod
