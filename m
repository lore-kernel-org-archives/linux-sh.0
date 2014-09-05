From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 05 Sep 2014 15:27:18 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Init Delay Updates For v3.18
Message-Id: <201409051727.18845.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408927601.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408927601.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 25 August 2014, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC init delay updates for v3.18.
> 

While looking at your branches, I noticed that you go to great lengths
to compute the correct lpj value and avoid the calibration.

However, I believe the "modern" way to do this is to call
register_current_timer_delay() in order to base the delay loop
on the hardware timer instead of looping in the CPU. This is
more accurate and more robust against CPU frequency scaling.

I'm applying the patches now, but it's something you may want
to look at in the future. On a related topic, your clocksource
drivers could be simplified for the DT-only case by using
CLOCKSOURCE_OF_DECLARE() instead of early_platform_init(), but
I don't know what the impact would be for the arch/sh and legacy
mach-shmobile cases.

	Arnd
