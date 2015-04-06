From: Sekhar Nori <nsekhar@ti.com>
Date: Mon, 06 Apr 2015 05:51:38 +0000
Subject: Re: [PATCH 03/14] clkdev: get rid of redundant clk_add_alias() prototype in linux/clk.h
Message-Id: <55221EB8.7080403@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>

On Friday 03 April 2015 10:42 PM, Russell King wrote:
> clk_add_alias() is provided by clkdev, and is not part of the clk API.
> Howver, it is prototyped in two locations: linux/clkdev.h and
> linux/clk.h.  This is a mess.  Get rid of the redundant and unnecessary
> version in linux/clk.h.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-davinci/da850.c        |  1 +

For the DaVinci change:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

