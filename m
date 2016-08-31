From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 31 Aug 2016 09:35:13 +0000
Subject: [PATCH] i2c: shmobile: Use ARCH_SHMOBILE instead of SUPERH
Message-Id: <1472636113-26988-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

"i2c-sh_mobile" is used on sh7343, sh7366, sh7722, sh7723, and sh7724
only. As all of the above select ARCH_SHMOBILE, restrict its driver
dependencies from SUPERH to ARCH_SHMOBILE.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 1f3239ead0377426..6d94e2ec5b4f7183 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -836,7 +836,7 @@ config I2C_SH7760
 config I2C_SH_MOBILE
 	tristate "SuperH Mobile I2C Controller"
 	depends on HAS_DMA
-	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
+	depends on ARCH_SHMOBILE || ARCH_RENESAS || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Renesas SH-Mobile processor.
-- 
1.9.1

