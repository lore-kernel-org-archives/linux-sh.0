From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Dec 2014 09:39:31 +0000
Subject: [PATCH 01/02] ARM: shmobile: r8a7779: No TWD setup in C for Multiplatform
Message-Id: <20141216093931.14252.89982.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Skip the TWD setup in C for r8a7779 Multiplatform.
We should use DTS for the TWD device anyway.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20141216v2-v3.18
 No special dependencies

 arch/arm/mach-shmobile/smp-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2014-12-16 18:24:44.000000000 +0900
@@ -56,7 +56,7 @@ static struct rcar_sysc_ch *r8a7779_ch_c
 	[3] = &r8a7779_ch_cpu3,
 };
 
-#ifdef CONFIG_HAVE_ARM_TWD
+#if defined(CONFIG_HAVE_ARM_TWD) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, R8A7779_SCU_BASE + 0x600, 29);
 void __init r8a7779_register_twd(void)
 {
