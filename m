From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Nov 2013 07:59:56 +0000
Subject: [PATCH 04/05] ARM: shmobile: Add r8a7791 thermal platform device
Message-Id: <20131120075956.23557.51924.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120075921.23557.23231.sendpatchset@w520>
In-Reply-To: <20131120075921.23557.23231.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, horms@verge.net.au, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add a thermal platform device for the legacy case
on the r8a7791 SoC. This keeps the r8a7791 in sync
with the r8a7790 sister device.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7791.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2013-11-20 15:54:42.000000000 +0900
@@ -189,6 +189,17 @@ static struct resource irqc0_resources[]
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
@@ -213,6 +224,7 @@ void __init r8a7791_add_standard_devices
 {
 	r8a7791_add_dt_devices();
 	r8a7791_register_irqc(0);
+	r8a7791_register_thermal();
 }
 
 void __init r8a7791_init_early(void)
