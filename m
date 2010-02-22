From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 22 Feb 2010 04:40:59 +0000
Subject: [PATCH] mfd/mmc: SDHI Kconfig update
Message-Id: <20100222044059.4684.59850.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, sameo@linux.intel.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Enable the sh_mobile_sdhi mfd driver on SH-Mobile ARM
processors. While at it, make CONFIG_TMIO_MMC depend on
CONFIG_MFD_SH_MOBILE_SDHI.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mfd/Kconfig      |    2 +-
 drivers/mmc/host/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/drivers/mfd/Kconfig
+++ work/drivers/mfd/Kconfig	2010-02-22 13:26:47.000000000 +0900
@@ -37,7 +37,7 @@ config MFD_ASIC3
 
 config MFD_SH_MOBILE_SDHI
 	bool "Support for SuperH Mobile SDHI"
-	depends on SUPERH
+	depends on SUPERH || ARCH_SHMOBILE
 	select MFD_CORE
 	 ---help---
 	  This driver supports the SDHI hardware block found in many
--- 0001/drivers/mmc/host/Kconfig
+++ work/drivers/mmc/host/Kconfig	2010-02-22 13:27:30.000000000 +0900
@@ -368,7 +368,7 @@ config MMC_SDRICOH_CS
 
 config MMC_TMIO
 	tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
-	depends on MFD_TMIO || MFD_ASIC3 || SUPERH
+	depends on MFD_TMIO || MFD_ASIC3 || MFD_SH_MOBILE_SDHI
 	help
 	  This provides support for the SD/MMC cell found in TC6393XB,
 	  T7L66XB and also HTC ASIC3
