From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 24 Feb 2014 05:49:07 +0000
Subject: [PATCH] ARM: shmobile: Make use of r8a7790_add_standard_devices()
Message-Id: <20140224054907.1803.88038.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move non-PFC and non-GPIO devices off from r8a7790_pinmux_init()
and into r8a7790_add_standard_devices() which is the normal place
to keep regular devices in the legacy case.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 0009/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-02-24 14:15:51.000000000 +0900
@@ -185,12 +185,6 @@ void __init r8a7790_pinmux_init(void)
 	r8a7790_register_gpio(3);
 	r8a7790_register_gpio(4);
 	r8a7790_register_gpio(5);
-	r8a7790_register_i2c(0);
-	r8a7790_register_i2c(1);
-	r8a7790_register_i2c(2);
-	r8a7790_register_i2c(3);
-	r8a7790_register_audio_dmac(0);
-	r8a7790_register_audio_dmac(1);
 }
 
 #define __R8A7790_SCIF(scif_type, _scscr, index, baseaddr, irq)		\
@@ -308,6 +302,12 @@ void __init r8a7790_add_standard_devices
 	r8a7790_add_dt_devices();
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
+	r8a7790_register_i2c(0);
+	r8a7790_register_i2c(1);
+	r8a7790_register_i2c(2);
+	r8a7790_register_i2c(3);
+	r8a7790_register_audio_dmac(0);
+	r8a7790_register_audio_dmac(1);
 }
 
 void __init r8a7790_init_early(void)
