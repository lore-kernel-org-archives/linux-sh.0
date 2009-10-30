From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 04:24:32 +0000
Subject: [PATCH 07/09] sh: Use RSMEM for sleep code on sh7724
Message-Id: <20091030042432.11783.44657.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use RSMEM instead of ILMEM for sleep mode code storage on SH7724.
This allows us to use R-standby mode on SH7724.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/shmobile/pm.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- 0012/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-28 19:53:03.000000000 +0900
@@ -40,11 +40,15 @@ ATOMIC_NOTIFIER_HEAD(sh_mobile_post_slee
  * U-standby mode is low priority since it needs bootloader hacks
  */
 
-#define ILRAM_BASE 0xe5200000
+#ifdef CONFIG_CPU_SUBTYPE_SH7724
+#define RAM_BASE 0xfd800000 /* RSMEM */
+#else
+#define RAM_BASE 0xe5200000 /* ILRAM */
+#endif
 
 void sh_mobile_call_standby(unsigned long mode)
 {
-	void *onchip_mem = (void *)ILRAM_BASE;
+	void *onchip_mem = (void *)RAM_BASE;
 	struct sh_sleep_data *sdp = onchip_mem;
 	void (*standby_onchip_mem)(unsigned long, unsigned long);
 
@@ -55,7 +59,7 @@ void sh_mobile_call_standby(unsigned lon
 				   mode, NULL);
 
 	/* Let assembly snippet in on-chip memory handle the rest */
-	standby_onchip_mem(mode, ILRAM_BASE);
+	standby_onchip_mem(mode, RAM_BASE);
 
 	atomic_notifier_call_chain(&sh_mobile_post_sleep_notifier_list,
 				   mode, NULL);
@@ -73,7 +77,7 @@ void sh_mobile_register_self_refresh(uns
 				     void *pre_start, void *pre_end,
 				     void *post_start, void *post_end)
 {
-	void *onchip_mem = (void *)ILRAM_BASE;
+	void *onchip_mem = (void *)RAM_BASE;
 	void *vp;
 	struct sh_sleep_data *sdp;
 	int n;
