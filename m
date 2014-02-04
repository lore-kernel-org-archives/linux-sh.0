From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 04 Feb 2014 18:48:22 +0000
Subject: [PATCH 3/4] ARM: shmobile: koelsch: Enable I2C in defconfig
Message-Id: <1391539703-5787-4-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This enables I2C support in koelsch_defconfig.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/configs/koelsch_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 3015797..c3b3c9d 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -62,6 +62,8 @@ CONFIG_SH_ETH=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS 
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_I2C=y
+CONFIG_I2C_RCAR=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
1.8.3.1

