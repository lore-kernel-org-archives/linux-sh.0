From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Mar 2014 03:16:58 +0000
Subject: [PATCH] ARM: shmobile: Update r8a7791 CPU freq to 1500MHz in C
Message-Id: <20140306031658.10787.30196.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140306031536.10779.98781.sendpatchset@w520>
In-Reply-To: <20140306031536.10779.98781.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The correct maximum CPU frequency for r8a7791 is 1500 MHz
so update the r8a7791 SoC C code to reflect this.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7791.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-03-06 11:33:58.000000000 +0900
@@ -213,7 +213,7 @@ void __init r8a7791_add_standard_devices
 void __init r8a7791_init_early(void)
 {
 #ifndef CONFIG_ARM_ARCH_TIMER
-	shmobile_setup_delay(1300, 2, 4); /* Cortex-A15 @ 1300MHz */
+	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
 #endif
 }
 
