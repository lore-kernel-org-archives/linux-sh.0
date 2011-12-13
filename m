From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 13 Dec 2011 11:09:35 +0000
Subject: [PATCH] ARM: mach-shmobile: fix AP4EVB A3SP domain PM
Message-Id: <Pine.LNX.4.64.1112131208520.17205@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On SH7372 it is important to stop MSTP clock of all registered USB host
devices. Otherwise powering down the A3SP domain will become impossible:
the domain-specific bit in SPDCR will remain set. Subsequently, any attempt
to power down any further domains will fail in the same way. To fix this
problem the USB1 host device has to be added to the A3SP domain on AP4EVB,
similarly as it is done on mackerel.
While not that critical, this patch also adds the HDMI device to the A4LC
domain.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 7e90d06..15a210a 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1412,6 +1412,8 @@ static void __init ap4evb_init(void)
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sh_mmcif_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi0_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &usb1_host_device);
+	sh7372_add_device_to_domain(&sh7372_a4lc, &hdmi_device);
 	sh7372_add_device_to_domain(&sh7372_a4r, &ceu_device);
 
 	hdmi_init_pm_clock();
-- 
1.7.2.5

