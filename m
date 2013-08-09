From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 09 Aug 2013 09:48:55 +0000
Subject: [PATCH 06/14] ARM: shmobile: Remove sh73a0_init_irq_dt()
Message-Id: <20130809094855.6530.42606.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130809094748.6530.16511.sendpatchset@w520>
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove left over function prototype sh73a0_init_irq_dt().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/sh73a0.h |    1 -
 1 file changed, 1 deletion(-)

--- 0009/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ work/arch/arm/mach-shmobile/include/mach/sh73a0.h	2013-08-08 16:04:29.000000000 +0900
@@ -73,7 +73,6 @@ enum {
 
 extern void sh73a0_init_delay(void);
 extern void sh73a0_init_irq(void);
-extern void sh73a0_init_irq_dt(void);
 extern void sh73a0_map_io(void);
 extern void sh73a0_earlytimer_init(void);
 extern void sh73a0_add_early_devices(void);
