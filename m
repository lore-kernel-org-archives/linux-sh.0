From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 02 Dec 2013 02:19:30 +0000
Subject: [PATCH 24/28] ARM: shmobile: Add r8a7791 thermal platform device
Message-Id: <2e83b75b6740c73f1ffc92149101ffb788d871d3.1385950394.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a thermal platform device for the legacy case
on the r8a7791 SoC. This keeps the r8a7791 in sync
with the r8a7790 sister device.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7791.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 59dd442..cddca99 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -189,6 +189,17 @@ static struct resource irqc0_resources[] = {
 					  &irqc##idx##_data,		\
 					  sizeof(struct renesas_irqc_config))
 
+static const struct resource thermal_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe61f0000, 0x14),
+	DEFINE_RES_MEM(0xe61f0100, 0x38),
+	DEFINE_RES_IRQ(gic_spi(69)),
+};
+
+#define r8a7791_register_thermal()					\
+	platform_device_register_simple("rcar_thermal", -1,		\
+					thermal_resources,		\
+					ARRAY_SIZE(thermal_resources))
+
 void __init r8a7791_add_dt_devices(void)
 {
 	r8a7791_register_scif(SCIFA0);
@@ -213,6 +224,7 @@ void __init r8a7791_add_standard_devices(void)
 {
 	r8a7791_add_dt_devices();
 	r8a7791_register_irqc(0);
+	r8a7791_register_thermal();
 }
 
 void __init r8a7791_init_early(void)
-- 
1.8.4

