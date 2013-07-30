From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 30 Jul 2013 07:01:55 +0000
Subject: [PATCH 1/2 v3] ARM: shmobile: r8a7778: i2c should not be called from C in DT
Message-Id: <87bo5kedk0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

c9fa47e287b304f3df02fc4b4b683a8d394bb9a4
(ARM: shmobile: r8a7778: cleanup registration of i2c)
added i2c register functions,
but i2c will be called from C code in DT case.
This patch fixup it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - fixup v2's miss

 arch/arm/mach-shmobile/setup-r8a7778.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index e975fcc1..ce3b54d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -303,15 +303,15 @@ void __init r8a7778_add_dt_devices(void)
 
 	r8a7778_register_tmu(0);
 	r8a7778_register_tmu(1);
-	r8a7778_register_i2c(0);
-	r8a7778_register_i2c(1);
-	r8a7778_register_i2c(2);
-	r8a7778_register_i2c(3);
 }
 
 void __init r8a7778_add_standard_devices(void)
 {
 	r8a7778_add_dt_devices();
+	r8a7778_register_i2c(0);
+	r8a7778_register_i2c(1);
+	r8a7778_register_i2c(2);
+	r8a7778_register_i2c(3);
 }
 
 void __init r8a7778_init_late(void)
-- 
1.7.9.5

