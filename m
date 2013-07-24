From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 24 Jul 2013 00:33:56 +0000
Subject: [PATCH 02/16] ARM: shmobile: r8a7790: add thermal driver support
Message-Id: <0b8eeba45143030e29ec39c43daa1383146581e6.1374624383.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374624383.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1374624383.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The current temperature may be read using:
cat /sys/class/thermal/thermal_zone0/temp

Based on similar work for the r8a73a4 by Kuninori Morimoto.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index b7e78b9..bc40a44 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -148,6 +148,17 @@ static struct resource irqc0_resources[] __initdata = {
 					  &irqc##idx##_data,		\
 					  sizeof(struct renesas_irqc_config))
 
+static struct resource thermal_resources[] __initdata = {
+	DEFINE_RES_MEM(0xe61f0000, 0x14),
+	DEFINE_RES_MEM(0xe61f0100, 0x38),
+	DEFINE_RES_IRQ(gic_spi(69)),
+};
+
+#define r8a7790_register_thermal()					\
+	platform_device_register_simple("rcar_thermal", -1,		\
+					thermal_resources,		\
+					ARRAY_SIZE(thermal_resources))
+
 void __init r8a7790_add_standard_devices(void)
 {
 	r8a7790_register_scif(SCIFA0);
@@ -161,6 +172,7 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_scif(HSCIF0);
 	r8a7790_register_scif(HSCIF1);
 	r8a7790_register_irqc(0);
+	r8a7790_register_thermal();
 }
 
 void __init r8a7790_timer_init(void)
-- 
1.8.2.1

