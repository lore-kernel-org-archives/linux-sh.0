From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Mar 2015 01:07:28 +0000
Subject: [PATCH 3/4] ARM: shmobile: defconfig: Drop useless SERIAL_8250_EXTENDED=y
Message-Id: <212c23924c09aa63ea4f2358875eee7feb1ce37d.1426813316.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1426813316.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1426813316.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

SERIAL_8250_EXTENDED only serves as a guard for other Kconfig options,
none of which is enabled in shmobile_defconfig.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d206041..1155415 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -93,7 +93,6 @@ CONFIG_INPUT_ADXL34X=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS 
-- 
2.1.4

