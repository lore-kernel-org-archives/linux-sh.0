From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 29 Oct 2013 22:37:38 +0000
Subject: [PATCH v2 03/19] i2c: sh_mobile: Enable the driver on all ARM platforms
Message-Id: <1383086274-11049-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Renesas ARM platforms are transitioning from single-platform to
multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
COMPILE_TEST.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index cdcbd83..c50f092 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -665,7 +665,7 @@ config I2C_SH7760
 
 config I2C_SH_MOBILE
 	tristate "SuperH Mobile I2C Controller"
-	depends on SUPERH || ARCH_SHMOBILE
+	depends on SUPERH || ARM || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
 	  built-in I2C interface on the Renesas SH-Mobile processor.
-- 
1.8.1.5

