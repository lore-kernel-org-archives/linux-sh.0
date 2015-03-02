From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 02 Mar 2015 21:50:44 +0000
Subject: Re: [PATCH 00/10] initial clkdev cleanups
Message-Id: <54F4DB34.9000507@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
In-Reply-To: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Roland Stigge <stigge@antcom.de>, Andrew Lunn <andrew@lunn.ch>, Mike Turquette <mturquette@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On 03/02/15 09:05, Russell King - ARM Linux wrote:
> Here's some initial clkdev cleanups.  These are targetted for the next
> merge window, and while the initial patches can be merged independently,
> I'd prefer to keep the series together as further work on solving the
> problems which unique struct clk's has introduced is needed.
>
> The initial cleanups are more about using the correct clkdev function
> than anything else: there's no point interating over a array of
> clk_lookup structs, adding each one in turn when we have had a function
> which does this since forever.

The clkdev_add_table() conversions look good.

>
> I'm also killing a chunk of seemingly unused code in the omap3isp driver.
>
> Lastly, I'm introducing a clkdev_create() helper, which combines the
> clkdev_alloc() + clkdev_add() pattern which keeps cropping up.
>

We already have a solution to that problem with clk_register_clkdev().
Andy has done some work to make clk_register_clkdev() return a struct
clk_lookup pointer[1]. Maybe we can do that instead of introducing a new
clkdev_create() function. There is some benefit to having a new function
though so that we can avoid a flag day, although it looks like the flag
day is small in this case so it might not actually matter.

[1] https://www.marc.info/?l=linux-kernel&m2469226512289

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

