From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Aug 2014 13:26:21 +0000
Subject: [PATCH 4/5] ARM: shmobile: armadillo800eva legacy: Use rmobile_add_devices_to_domains()
Message-Id: <1409318782-28133-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use a table and the rmobile_add_devices_to_domains() helper function to
add all platform devices to their power domains at once, which is more
size-efficient than calling rmobile_add_device_to_domain() explicitly
for all devices individually.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 3d07a9a95da2..f19459a8c3ed 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1231,6 +1231,10 @@ clock_error:
 #define GPIO_PORT8CR	IOMEM(0xe6050008)
 static void __init eva_init(void)
 {
+	static struct pm_domain_device domain_devices[] __initdata = {
+		{ "A4LC", &lcdc0_device },
+		{ "A4LC", &hdmi_lcdc_device },
+	};
 	struct platform_device *usb = NULL;
 
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
@@ -1316,8 +1320,8 @@ static void __init eva_init(void)
 	platform_add_devices(eva_devices,
 			     ARRAY_SIZE(eva_devices));
 
-	rmobile_add_device_to_domain("A4LC", &lcdc0_device);
-	rmobile_add_device_to_domain("A4LC", &hdmi_lcdc_device);
+	rmobile_add_devices_to_domains(domain_devices,
+				       ARRAY_SIZE(domain_devices));
 	if (usb)
 		rmobile_add_device_to_domain("A3SP", usb);
 
-- 
1.7.9.5

