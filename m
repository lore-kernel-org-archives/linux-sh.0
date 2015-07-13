From: Simon Horman <horms@verge.net.au>
Date: Mon, 13 Jul 2015 01:04:06 +0000
Subject: Re: [PATCH] ARM: shmobile: apmu: silence build warnings
Message-Id: <20150713010406.GA25443@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1436561296-29141-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436561296-29141-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Fri, Jul 10, 2015 at 10:48:16PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> With shmobile_defconfig but SMP=n && SUSPEND=n, I get:
> 
> arch/arm/mach-shmobile/platsmp-apmu.c:49:12: warning: 'apmu_power_off' defined but not used [-Wunused-function]
> arch/arm/mach-shmobile/platsmp-apmu.c:70:12: warning: 'apmu_wrap' defined but not used [-Wunused-function]
> 
> Annotate those functions like the functions around it.

thanks for noticing this.

I'm not familiar with when it is appropriate to use __maybe_unused but does
anything speak against using #if as per the conditional compilation of the
callers in platsmp-apmu.c of the above functions?

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index b0790fc32282..54cf153b570f 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -46,12 +46,14 @@ static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
 	return 0;
 }
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND)
 static int apmu_power_off(void __iomem *p, int bit)
 {
 	/* request Core Standby for next WFI */
 	writel_relaxed(3, p + CPUNCR_OFFS(bit));
 	return 0;
 }
+#endif
 
 static int __maybe_unused apmu_power_off_poll(void __iomem *p, int bit)
 {
@@ -67,12 +69,14 @@ static int __maybe_unused apmu_power_off_poll(void __iomem *p, int bit)
 	return 0;
 }
 
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_SUSPEND) || defined(CONFIG_SMP)
 static int apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu))
 {
 	void __iomem *p = apmu_cpus[cpu].iomem;
 
 	return p ? fn(p, apmu_cpus[cpu].bit) : -EINVAL;
 }
+#endif
 
 static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 {
