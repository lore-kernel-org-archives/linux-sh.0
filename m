From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Apr 2013 05:33:56 +0000
Subject: [RFC][PATCH 3/4] ARM: shmobile: r8a7778: Register PFC drivce
Message-Id: <8738v0b73z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 951149e..68053fc 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -28,5 +28,6 @@ extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
+extern void r8a7778_pinmux_init(void);
 
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index d6ee521..6c1cc80 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -102,6 +102,19 @@ void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
 					  pdata, sizeof(*pdata));
 }
 
+/* PFC */
+static struct resource pfc_resources[] = {
+	DEFINE_RES_MEM(0xfffc0000, 0x118),
+};
+
+void __init r8a7778_pinmux_init(void)
+{
+	platform_device_register_simple(
+		"pfc-r8a7778", -1,
+		pfc_resources,
+		ARRAY_SIZE(pfc_resources));
+}
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
-- 
1.7.9.5

