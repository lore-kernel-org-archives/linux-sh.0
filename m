From: Simon Horman <horms@verge.net.au>
Date: Wed, 04 Sep 2013 08:31:41 +0000
Subject: Re: [PATCH] clocksource: em_sti: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <20130904083139.GD17329@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130904080151.24562.91334.sendpatchset@w520>
In-Reply-To: <20130904080151.24562.91334.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, johnstultz@linaro.org, linux@arm.linux.org.uk, arnd@arndb.de, linux-sh@vger.kernel.org, sboyd@codeaurora.org, rob.herring@calxeda.com, olof@lixom.net, santosh.shilimkar@ti.com, grant.likely@linaro.org, tglx@linutronix.de

On Wed, Sep 04, 2013 at 05:01:51PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the STI driver by setting cpu_possible_mask to make EMEV2
> SMP work as expected together with the ARM broadcast timer.
> 
> This breakage was introduced by:
> 
> f7db706 ARM: 7674/1: smp: Avoid dummy clockevent being preferred over real hardware clock-event
> 
> Without this fix SMP operation is broken on EMEV2 since no
> broadcast timer interrupts trigger on the secondary CPU cores.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Thanks to feedback from Stephen Boyd this is is a reworked version of:
>  [PATCH] clocksource: em_sti: Adjust clock event rating to fix SMP broadcast
> 
>  drivers/clocksource/em_sti.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Simon Horman <horms+renesas@verge.net.au>

I will let this sit for a few days to see if there is any further feedback.

