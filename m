From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 16 Apr 2014 06:03:08 +0000
Subject: [PATCH 3/7] ARM: shmobile: Include at24.c in shmobile_defconfig
Message-Id: <f5e1367f8f94293f098cab3e906934e535df1a94.1397627278.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397627278.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397627278.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The Koelsch board includes an at24-compatible EEPROM hooked up via I2C.
To increase hardware support enable the driver in the shmobile_defconfig
multiplatform configuration.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d96133a..146ee70 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -43,6 +43,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
+CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_RCAR=y
-- 
1.8.5.2

