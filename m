From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 04 Mar 2008 22:08:52 +0000
Subject: [HP j6xx] - Make APM output some very basic information
Message-Id: <20080304230925.4c8eddb0.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes the old non-verbose hp6xx apm code and enables some very basic apm output.
We now get percentage (battery) output and basic time estimate.

Signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

diff --git a/arch/sh/boards/hp6xx/hp6xx_apm.c b/arch/sh/boards/hp6xx/hp6xx_apm.c
index 640ca2a..52f5228 100644
--- a/arch/sh/boards/hp6xx/hp6xx_apm.c
+++ b/arch/sh/boards/hp6xx/hp6xx_apm.c
@@ -1,6 +1,7 @@
 /*
  * bios-less APM driver for hp680
  *
+ * Copyright 2008 (c) Kristoffer Ericson <kristoffer.ericson@gmail.com>
  * Copyright 2005 (c) Andriy Skulysh <askulysh@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
@@ -15,11 +16,11 @@
 #include <asm/adc.h>
 #include <asm/hp6xx.h>
 
-#define SH7709_PGDR			0xa400012c
-
+/* percentage values */
 #define APM_CRITICAL			10
 #define APM_LOW				30
 
+/* resonably sane values */
 #define HP680_BATTERY_MAX		898
 #define HP680_BATTERY_MIN		486
 #define HP680_BATTERY_AC_ON		1023
@@ -38,17 +39,26 @@ static void hp6x0_apm_get_power_status(struct apm_power_info *info)
 	percentage = 100 * (battery - HP680_BATTERY_MIN) /
 			   (HP680_BATTERY_MAX - HP680_BATTERY_MIN);
 
+	/* % of full battery */
+	info->battery_life = percentage;
+
+	/* We want our estimates in minutes */
+	info->units = 0;
+
+	/* Extremely(!!) rough estimate, we will replace this with a datalist later on */
+	info->time = (2 * battery);
+
 	info->ac_line_status = (battery > HP680_BATTERY_AC_ON) ?
 			 APM_AC_ONLINE : APM_AC_OFFLINE;
 
-	pgdr = ctrl_inb(SH7709_PGDR);
+	pgdr = ctrl_inb(PGDR);
 	if (pgdr & PGDR_MAIN_BATTERY_OUT) {
 		info->battery_status	= APM_BATTERY_STATUS_NOT_PRESENT;
 		info->battery_flag	= 0x80;
 	} else if (charging < 8) {
 		info->battery_status	= APM_BATTERY_STATUS_CHARGING;
 		info->battery_flag	= 0x08;
-		info->ac_line_status = 0xff;
+		info->ac_line_status	= 0x01;
 	} else if (percentage <= APM_CRITICAL) {
 		info->battery_status	= APM_BATTERY_STATUS_CRITICAL;
 		info->battery_flag	= 0x04;
@@ -59,8 +69,6 @@ static void hp6x0_apm_get_power_status(struct apm_power_info *info)
 		info->battery_status	= APM_BATTERY_STATUS_HIGH;
 		info->battery_flag	= 0x01;
 	}
-
-	info->units = 0;
 }
 
 static irqreturn_t hp6x0_apm_interrupt(int irq, void *dev)
@@ -71,6 +79,8 @@ static irqreturn_t hp6x0_apm_interrupt(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+extern void (*apm_get_power_status)(struct apm_power_info *);
+
 static int __init hp6x0_apm_init(void)
 {
 	int ret;


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
