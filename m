From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 30 Jun 2011 09:47:18 +0000
Subject: [PATCH 03/03] ARM: mach-shmobile: sh7372 power domain LED hack
Message-Id: <20110630094718.10442.53311.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Hack to hook up LED1->LED4 on the Mackerel board
to show the state of the power domains:

LED1: ARM core
LED2: A4LC
LED3: A3RV
LED4: A3SP

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pm-sh7372.c |   49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

--- 0005/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-06-30 17:06:38.000000000 +0900
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
@@ -43,6 +44,19 @@ static int pd_power_down(struct generic_
 	struct sh7372_pm_domain *sh7372_pd = to_sh7372_pd(genpd);
 	unsigned int mask = 1 << sh7372_pd->bit_shift;
 
+#ifndef CONFIG_LEDS_GPIO
+	/* LED2: A4LC status - LED off when power off */
+	if (genpd = &sh7372_a4lc.genpd)
+		gpio_set_value(GPIO_PORT1, 0);
+
+	/* LED3: A3RV status - LED off when power off */
+	if (genpd = &sh7372_a3rv.genpd)
+		gpio_set_value(GPIO_PORT2, 0);
+
+	/* LED4: A3SP status - LED off when power off */
+	if (genpd = &sh7372_a3sp.genpd)
+		gpio_set_value(GPIO_PORT159, 0);
+#endif
 	if (__raw_readl(PSTR) & mask) {
 		unsigned int retry_count;
 
@@ -70,6 +84,19 @@ static int pd_power_up(struct generic_pm
 	unsigned int retry_count;
 	int ret = 0;
 
+#ifndef CONFIG_LEDS_GPIO
+	/* LED2: A4LC status - LED lit when power on */
+	if (genpd = &sh7372_a4lc.genpd)
+		gpio_set_value(GPIO_PORT1, 1);
+
+	/* LED3: A3RV status - LED lit when power on */
+	if (genpd = &sh7372_a3rv.genpd)
+		gpio_set_value(GPIO_PORT2, 1);
+
+	/* LED4: A3SP status - LED lit when power on */
+	if (genpd = &sh7372_a3sp.genpd)
+		gpio_set_value(GPIO_PORT159, 1);
+#endif
 	if (__raw_readl(PSTR) & mask)
 		goto out;
 
@@ -145,6 +172,11 @@ static void sh7372_enter_core_standby(vo
 {
 	void __iomem *smfram = (void __iomem *)SMFRAM;
 
+#ifndef CONFIG_LEDS_GPIO
+	/* LED1: ARM core status - LED off when power off */
+	gpio_set_value(GPIO_PORT0, 0);
+#endif
+
 	__raw_writel(0, APARMBAREA); /* translate 4k */
 	__raw_writel(__pa(sh7372_cpu_resume), SBAR); /* set reset vector */
 	__raw_writel(0x10, SYSTBCR); /* enable core standby */
@@ -165,6 +197,11 @@ static void sh7372_enter_core_standby(vo
 
 	__raw_writel(0, SYSTBCR); /* disable core standby */
 	__raw_writel(0, SBAR); /* disable reset vector translation */
+
+#ifndef CONFIG_LEDS_GPIO
+	/* LED1: ARM core status - LED lit when power on */
+	gpio_set_value(GPIO_PORT0, 1);
+#endif
 }
 
 #ifdef CONFIG_CPU_IDLE
@@ -222,6 +259,18 @@ void __init sh7372_pm_init(void)
 	/* do not convert A3SM, A3SP, A3SG, A4R power down into A4S */
 	__raw_writel(0, PDNSEL);
 
+#ifndef CONFIG_LEDS_GPIO
+	/* output power domain state of LED1 -> LED4 */
+	gpio_request(GPIO_PORT0, NULL); /* LED1 */
+	gpio_direction_output(GPIO_PORT0, 1);
+	gpio_request(GPIO_PORT1, NULL); /* LED2 */
+	gpio_direction_output(GPIO_PORT1, 1);
+	gpio_request(GPIO_PORT2, NULL); /* LED3 */
+	gpio_direction_output(GPIO_PORT2, 1);
+	gpio_request(GPIO_PORT159, NULL); /* LED4 */
+	gpio_direction_output(GPIO_PORT159, 1);
+#endif
+
 	sh7372_suspend_init();
 	sh7372_cpuidle_init();
 }
