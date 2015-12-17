From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 17 Dec 2015 12:09:32 +0000
Subject: [PATCH] i2c: emev: select I2C slave support
Message-Id: <1450354172-5656-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Until we have proper support to make I2C slave support fully optional,
select it to prevent build errors on randconfigs.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index eaa7b4a0e48438..0299dfa746a387 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -532,6 +532,7 @@ config I2C_EG20T
 config I2C_EMEV2
 	tristate "EMMA Mobile series I2C adapter"
 	depends on HAVE_CLK
+	select I2C_SLAVE
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C interface on the Renesas Electronics EM/EV family of processors.
-- 
2.1.4

