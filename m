From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:02:54 +0000
Subject: [PATCH 06/10] ARM: shmobile: r8a7778: Use shmobile_init_delay()
Message-Id: <20140820130254.32075.82301.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a7778 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7778.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7778.c
+++ work/arch/arm/mach-shmobile/setup-r8a7778.c	2014-08-20 21:17:45.000000000 +0900
@@ -574,7 +574,7 @@ void __init r8a7778_init_irq_extpin(int
 
 void __init r8a7778_init_delay(void)
 {
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+	shmobile_init_delay();
 }
 
 #ifdef CONFIG_USE_OF
