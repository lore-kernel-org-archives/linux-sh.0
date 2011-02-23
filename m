From: Saravana Kannan <skannan@codeaurora.org>
Date: Wed, 23 Feb 2011 04:17:01 +0000
Subject: Re: [PATCH] wip: convert imx27 to common struct clk
Message-Id: <4D648A3D.7020402@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1298256658.861611.43913489619.0.gpush@pororo>
	<1298417599-23522-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1298417599-23522-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On 02/22/2011 03:33 PM, Uwe Kleine-König wrote:
> Signed-off-by: Uwe Kleine-König<u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>
> on top of .38-rc6 + making the clk_{un,}prepare stubs static inline,
> this patch makes use of Jeremy's common struct clk (v13) on a i.MX27 based
> machine.
>
> This is compile tested using mx21_defconfig and runtime tested using
> mx27_defconfig.
>
> I had to degrade one WARN_ON to WARN_ON_ONCE in drivers/clk/clk.c to
> actually make it work.  Otherwise console output results in a warning
> that results in console output ...

You won't be able to do mainline the WARN_ON_ONCE because that will only 
warn for the first clock that violates whatever condition it's warning 
about.

Your probably need to fix your serial driver. What serial driver are you 
using?

-Saravana

