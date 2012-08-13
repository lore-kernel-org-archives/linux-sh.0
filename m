From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 12:34:26 +0000
Subject: [PATCH 2/2] ARM: shmobile: Rework adding devices to PM domains on AP4EVB
Message-Id: <201208131434.27135.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Use the function rmobile_add_devices_to_domains() introduced
previously for adding devices to PM domains during the AP4EVB
initialization instead of a series of rmobile_add_device_to_domain*()
calls.  This also causes the default device PM QoS latencies to be
used on that board in analogy with Mackerel.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

Index: linux/arch/arm/mach-shmobile/board-ap4evb.c
=================================--- linux.orig/arch/arm/mach-shmobile/board-ap4evb.c
+++ linux/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1229,6 +1229,15 @@ static struct i2c_board_info i2c1_device
 #define USCCR1		0xE6058144
 static void __init ap4evb_init(void)
 {
+	struct pm_domain_device domain_devices[] = {
+		{ "A4LC", &lcdc1_device, },
+		{ "A4LC", &lcdc_device, },
+		{ "A4MP", &fsi_device, },
+		{ "A3SP", &sh_mmcif_device, },
+		{ "A3SP", &sdhi0_device, },
+		{ "A3SP", &sdhi1_device, },
+		{ "A4R", &ceu_device, },
+	};
 	u32 srcr4;
 	struct clk *clk;
 
@@ -1461,14 +1470,8 @@ static void __init ap4evb_init(void)
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
 
-	rmobile_add_device_to_domain("A4LC", &lcdc1_device);
-	rmobile_add_device_to_domain("A4LC", &lcdc_device);
-	rmobile_add_device_to_domain("A4MP", &fsi_device);
-
-	rmobile_add_device_to_domain("A3SP", &sh_mmcif_device);
-	rmobile_add_device_to_domain("A3SP", &sdhi0_device);
-	rmobile_add_device_to_domain("A3SP", &sdhi1_device);
-	rmobile_add_device_to_domain("A4R", &ceu_device);
+	rmobile_add_devices_to_domains(domain_devices,
+				       ARRAY_SIZE(domain_devices));
 
 	hdmi_init_pm_clock();
 	fsi_init_pm_clock();

