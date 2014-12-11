From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 11 Dec 2014 21:52:10 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <1729516.HWbfnj3Cpn@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de> <2462101.Er8OZg9N24@avalon> <20141211214732.GC21482@katana>
In-Reply-To: <20141211214732.GC21482@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org

On Thursday 11 December 2014 22:47:32 Wolfram Sang wrote:
> > > Note that the I2C drives uses subsys_initcall() for historic reasons,
> > > while the DMA driver uses module_init(). This is hard to revert without
> > > introducing potential regressions on older boards. So, the I2C DMA
> > > support needs to handle deferred probe definately. I am with Laurent, I
> > > don't see any other way, but I'd be glad to be enlightened...
> > 
> > While I believe that requesting the channel at transfer time is the good
> > solution, I think we should still try to move to module initcalls where
> > possible. The risk of regressions is real so proper testing is needed. My
> > question is, have you tried it ?
> 
> I would need to test all boards using this driver to not fail booting.
> Usually I2C drivers are moved to subsys_initcall because they need
> access to something critical (PMIC, GPIOs...) early. I don't see a sane
> way to do that testing.

Still, I would like to get a better view on the problems we should expect, by 
testing this on the latest boards for instance.

> Other than that, even if we move to module_init, we reduce the chance of
> getting a deferred probe, but we do not eliminate it...

Sure, but reducing the chance of deferred probe is a good idea in my opinion 
:-)

-- 
Regards,

Laurent Pinchart

