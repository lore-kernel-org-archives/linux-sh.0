From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Jul 2013 05:53:11 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7778: add r8a7778_add_usb_host_device()
Message-Id: <87d2qsth2z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The USB host driver was registered in compulsorily
on current r8a7778 SoC code.
But it should be decided on platform, not SoC.
This patch adds r8a7778_add_usb_host_device() for it.

Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c          |    7 ++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    3 ++-
 arch/arm/mach-shmobile/setup-r8a7778.c        |   13 ++++++-------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 6f541ad..a57be8a 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -232,6 +232,11 @@ static void __init bockw_init(void)
 	}
 }
 
+static void __init bockw_init_late(void)
+{
+	r8a7778_add_usb_host_device();
+}
+
 static const char *bockw_boards_compat_dt[] __initdata = {
 	"renesas,bockw",
 	NULL,
@@ -243,5 +248,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_machine	= bockw_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= bockw_boards_compat_dt,
-	.init_late      = r8a7778_init_late,
+	.init_late      = bockw_init_late,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 2e36264..dd775b3 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -29,8 +29,9 @@ extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
 extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
-
 extern void r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
+extern void r8a7778_add_usb_host_device(void);
+
 extern void r8a7778_init_late(void);
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index cd98079..2fa1c0d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -203,6 +203,12 @@ static struct platform_device_info hci##_info __initdata = {	\
 USB_PLATFORM_INFO(ehci);
 USB_PLATFORM_INFO(ohci);
 
+void __init r8a7778_add_usb_host_device(void)
+{
+	platform_device_register_full(&ehci_info);
+	platform_device_register_full(&ohci_info);
+}
+
 /* Ether */
 static struct resource ether_resources[] __initdata = {
 	DEFINE_RES_MEM(0xfde00000, 0x400),
@@ -372,12 +378,6 @@ void __init r8a7778_add_standard_devices(void)
 	r8a7778_register_tmu(1);
 }
 
-void __init r8a7778_init_late(void)
-{
-	platform_device_register_full(&ehci_info);
-	platform_device_register_full(&ohci_info);
-}
-
 static struct renesas_intc_irqpin_config irqpin_platform_data __initdata = {
 	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
 	.sense_bitfield_width = 2,
@@ -480,7 +480,6 @@ DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a7778_compat_dt,
-	.init_late      = r8a7778_init_late,
 MACHINE_END
 
 #endif /* CONFIG_USE_OF */
-- 
1.7.9.5

