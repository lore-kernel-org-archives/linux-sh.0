From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 18 Feb 2013 13:47:16 +0000
Subject: [PATCH 03/08] ARM: shmobile: Use R8A7779_SCU_BASE with TWD
Message-Id: <20130218134716.17303.17033.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130218134648.17303.97576.sendpatchset@w520>
In-Reply-To: <20130218134648.17303.97576.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rework the IOMEM() usage for the SCU base address in the
case of r8a7779. Adjusts the TWD to use R8A7779_SCU_BASE.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a7779.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- 0003/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2013-02-18 16:21:10.000000000 +0900
@@ -32,7 +32,7 @@
 #include <asm/smp_twd.h>
 
 #define AVECR IOMEM(0xfe700040)
-#define R8A7779_SCU_BASE IOMEM(0xf0000000)
+#define R8A7779_SCU_BASE 0xf0000000
 
 static struct r8a7779_pm_ch r8a7779_ch_cpu1 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
@@ -59,8 +59,7 @@ static struct r8a7779_pm_ch *r8a7779_ch_
 };
 
 #ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
-
+static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, R8A7779_SCU_BASE + 0x600, 29);
 void __init r8a7779_register_twd(void)
 {
 	twd_local_timer_register(&twd_local_timer);
@@ -178,7 +177,7 @@ static void __init r8a7779_smp_prepare_c
 static void __init r8a7779_smp_init_cpus(void)
 {
 	/* setup r8a7779 specific SCU base */
-	shmobile_scu_base = R8A7779_SCU_BASE;
+	shmobile_scu_base = IOMEM(R8A7779_SCU_BASE);
 
 	shmobile_smp_init_cpus(scu_get_core_count(shmobile_scu_base));
 }
