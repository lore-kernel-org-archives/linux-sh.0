From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 16 Apr 2014 06:03:48 +0000
Subject: [PATCH 5/8] ARM: shmobile: Make use of r8a7790_add_standard_devices()
Message-Id: <f05b4b52845a18e833644eb3a820a55e3278d2b4.1397627619.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397627619.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397627619.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move non-PFC and non-GPIO devices off from r8a7790_pinmux_init()
and into r8a7790_add_standard_devices() which is the normal place
to keep regular devices in the legacy case.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index c4616f0..a901d9e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
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
@@ -308,6 +302,12 @@ void __init r8a7790_add_standard_devices(void)
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
-- 
1.8.5.2

