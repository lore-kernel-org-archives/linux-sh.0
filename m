From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 16 Apr 2014 06:03:07 +0000
Subject: [PATCH 2/7] ARM: shmobile: Include i2c-shmobile.c in shmobile_defconfig
Message-Id: <c2e90c4b7c15fbb2215b47a23b446ba53e6dbf59.1397627278.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397627278.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397627278.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Many SoCs include I2C controller instances compatible with
the i2c-shmobile.c driver. To increase hardware support enable
the driver in the shmobile_defconfig multiplatform configuration.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 2a27d46..d96133a 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -75,6 +75,7 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS 
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_I2C_GPIO=y
+CONFIG_I2C_SH_MOBILE=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
-- 
1.8.5.2

