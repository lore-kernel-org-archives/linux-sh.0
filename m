From: Simon Horman <horms@verge.net.au>
Date: Mon, 28 Apr 2014 06:55:02 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: Enable shmobile Runtime PM from MSTP clock driver
Message-Id: <20140428065500.GA21494@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398445124-16828-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1398445124-16828-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 28, 2014 at 07:45:38AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Apr 28, 2014 at 2:10 AM, Simon Horman <horms@verge.net.au> wrote:
> >> --- a/drivers/sh/pm_runtime.c
> >> +++ b/drivers/sh/pm_runtime.c
> >> @@ -75,20 +75,24 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
> >>       .con_ids = { NULL, },
> >>  };
> >>
> >> -static bool default_pm_on;
> >> +#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE_LEGACY)
> >> +bool default_pm_on = true;
> >> +#else
> >> +bool default_pm_on;
> >> +#endif
> >
> > I wonder if there is some way we can get the compiler
> > to optimise out code in the case of default_pm_on = false,
> > perhaps by using IS_ENABLED() in conjunction with a Kconfig variable.
> 
> What's the use case of that?
> 
> This code is compiled only if SUPERH || ARCH_SHMOBILE_LEGACY ||
> ARCH_SHMOBILE_MULTIPLATORM.
> If should always be used when running on shmobile.

Sorry, I missed that point.
Please ignore my previous comment.
