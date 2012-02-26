From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 26 Feb 2012 22:57:01 +0000
Subject: Re: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <201202262357.01942.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1329111377-15676-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1329111377-15676-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday, February 23, 2012, Simon Horman wrote:
> This allows the mackerel to boot using a kernel compiled
> using the mackerel default config. Without this change
> the kernel boot hangs during or immediately after SCIF
> initialisation.
> 
> SuperH SCI(F) driver initialized
> sh-sci.0: ttySC0 at MMIO 0xe6c40000 (irq = 80) is a scifa
> sh-sci sh-sci.0: start latency exceeded, new value 5416 ns
> console [ttySC0] enabled, bootconsole disabled
> console [ttySC0] enabled, bootconsole disabled
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> ---
> 
> Hi Rafael,
> 
> I would appreciate it if you could consider this change for 3.3.
> 
> It is a band-aid solution, however, it resolves a regression -
> the boot or lack thereof of a mackerel board using the default config -
> since 3.2.
> 
> I have discussed this a little with Magnus Damm and he is of
> the opinion that this problem likely relates to an interaction
> between TMU and power domains and that a full fix would be difficult
> within the 3.3 time-frame.

From my inspection of the sh_tmu driver it looks like that driver doesn't
support power management and the device it handles isn't taken into account
in our PM domains configuration (it belongs to the A4R domain, so that
domain can't be powered off while the driver is present).

For this reason, I propose to apply the appended change (which reflects the
current status of the driver AFAICS) for now and revisit the driver at one
point in future.

Thanks,
Rafael

---
 arch/arm/mach-shmobile/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/arm/mach-shmobile/Kconfig
=================================--- linux.orig/arch/arm/mach-shmobile/Kconfig
+++ linux/arch/arm/mach-shmobile/Kconfig
@@ -151,7 +151,7 @@ config SH_TIMER_CMT
 
 config SH_TIMER_TMU
 	bool "TMU timer driver"
-	default y
+	depends on !PM
 	help
 	  This enables build of the TMU timer driver.
 
