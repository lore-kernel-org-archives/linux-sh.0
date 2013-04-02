From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 02 Apr 2013 03:35:58 +0000
Subject: Re: [PATCH v2 02/13] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
Message-Id: <515A4F4E.3060107@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
 <1364854883-5961-3-git-send-email-robherring2@gmail.com>
In-Reply-To: <1364854883-5961-3-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 02 April 2013 03:51 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This converts arm and arm64 to use CLKSRC_OF DT based initialization for
> the arch timer. A new function arch_timer_arch_init is added to allow for
> arch specific setup.
> 
> This has a side effect of enabling sched_clock on omap5 and exynos5. There
> should not be any reason not to use the arch timers for sched_clock.
> 
Absolutely.

> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

[..]

>  arch/arm/mach-omap2/timer.c                  |    5 +----

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

