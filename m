From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 21 Jul 2012 21:55:43 +0000
Subject: [RFC][PATCH 4/5] PM / shmobile: Specify device latencies for Mackerel devices directly
Message-Id: <201207212355.44071.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207212349.18294.rjw@sisk.pl>
In-Reply-To: <201207212349.18294.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Olof Johansson <olof@lixom.net>


The results of adaptive latency computations in
GENPD_DEV_TIMED_CALLBACK() show that the start/stop and save/restore
state latencies of all devices on the Mackerel board I have tried are
a little below 250 us.  Therefore, if the 250 us is used as the
common initial value of the latency fields in struct gpd_timing_data
for all devices on Mackerel, the latency values will never have to
change at run time and there won't be any overhead related to
re-computation of the corresponding PM QoS data.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/board-mackerel.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

Index: linux/arch/arm/mach-shmobile/board-mackerel.c
=================================--- linux.orig/arch/arm/mach-shmobile/board-mackerel.c
+++ linux/arch/arm/mach-shmobile/board-mackerel.c
@@ -1407,8 +1407,15 @@ static struct i2c_board_info i2c1_device
 #define GPIO_PORT168CR	0xE60520A8
 #define SRCR4		0xe61580bc
 #define USCCR1		0xE6058144
+#define DEV_LATENCY_NS	250000
 static void __init mackerel_init(void)
 {
+	struct gpd_timing_data latencies = {
+		.stop_latency_ns = DEV_LATENCY_NS,
+		.start_latency_ns = DEV_LATENCY_NS,
+		.save_state_latency_ns = DEV_LATENCY_NS,
+		.restore_state_latency_ns = DEV_LATENCY_NS,
+	};
 	u32 srcr4;
 	struct clk *clk;
 
@@ -1623,20 +1630,20 @@ static void __init mackerel_init(void)
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
 
-	rmobile_add_device_to_domain("A4LC", &lcdc_device);
-	rmobile_add_device_to_domain("A4LC", &hdmi_lcdc_device);
-	rmobile_add_device_to_domain("A4LC", &meram_device);
-	rmobile_add_device_to_domain("A4MP", &fsi_device);
-	rmobile_add_device_to_domain("A3SP", &usbhs0_device);
-	rmobile_add_device_to_domain("A3SP", &usbhs1_device);
-	rmobile_add_device_to_domain("A3SP", &nand_flash_device);
-	rmobile_add_device_to_domain("A3SP", &sh_mmcif_device);
-	rmobile_add_device_to_domain("A3SP", &sdhi0_device);
+	rmobile_add_device_to_domain_td("A4LC", &lcdc_device, &latencies);
+	rmobile_add_device_to_domain_td("A4LC", &hdmi_lcdc_device, &latencies);
+	rmobile_add_device_to_domain_td("A4LC", &meram_device, &latencies);
+	rmobile_add_device_to_domain_td("A4MP", &fsi_device, &latencies);
+	rmobile_add_device_to_domain_td("A3SP", &usbhs0_device, &latencies);
+	rmobile_add_device_to_domain_td("A3SP", &usbhs1_device, &latencies);
+	rmobile_add_device_to_domain_td("A3SP", &nand_flash_device, &latencies);
+	rmobile_add_device_to_domain_td("A3SP", &sh_mmcif_device, &latencies);
+	rmobile_add_device_to_domain_td("A3SP", &sdhi0_device, &latencies);
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
-	rmobile_add_device_to_domain("A3SP", &sdhi1_device);
+	rmobile_add_device_to_domain_td("A3SP", &sdhi1_device, &latencies);
 #endif
-	rmobile_add_device_to_domain("A3SP", &sdhi2_device);
-	rmobile_add_device_to_domain("A4R", &ceu_device);
+	rmobile_add_device_to_domain_td("A3SP", &sdhi2_device, &latencies);
+	rmobile_add_device_to_domain_td("A4R", &ceu_device, &latencies);
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();

