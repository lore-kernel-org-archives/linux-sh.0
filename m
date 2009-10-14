From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2009 10:18:39 +0000
Subject: [PATCH 02/07] sh: Use RSMEM for sh7724 sleep modes
Message-Id: <20091014101839.21842.14939.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Store sleep code in RSMEM on sh7724.

Not-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/shmobile/pm.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- 0001/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-13 14:47:04.000000000 +0900
@@ -34,18 +34,22 @@
  * U-standby mode is low priority since it needs bootloader hacks
  */
 
-#define ILRAM_BASE 0xe5200000
+#ifdef CONFIG_CPU_SUBTYPE_SH7724
+#define RAM_BASE 0xfd800000 /* RSMEM */
+#else
+#define RAM_BASE 0xe5200000 /* ILRAM */
+#endif
 
 extern const unsigned char sh_mobile_standby[];
 extern const unsigned int sh_mobile_standby_size;
 
 void sh_mobile_call_standby(unsigned long mode)
 {
-	void *onchip_mem = (void *)ILRAM_BASE;
+	void *onchip_mem = (void *)RAM_BASE;
 	void (*standby_onchip_mem)(unsigned long, unsigned long) = onchip_mem;
 
 	/* Let assembly snippet in on-chip memory handle the rest */
-	standby_onchip_mem(mode, ILRAM_BASE);
+	standby_onchip_mem(mode, RAM_BASE);
 }
 
 static int sh_pm_enter(suspend_state_t state)
@@ -65,9 +69,9 @@ static struct platform_suspend_ops sh_pm
 
 static int __init sh_pm_init(void)
 {
-	void *onchip_mem = (void *)ILRAM_BASE;
+	void *onchip_mem = (void *)RAM_BASE;
 
-	/* Copy the assembly snippet to the otherwise ununsed ILRAM */
+	/* Copy the assembly snippet to the otherwise ununsed on-chip RAM */
 	memcpy(onchip_mem, sh_mobile_standby, sh_mobile_standby_size);
 	wmb();
 	ctrl_barrier();
