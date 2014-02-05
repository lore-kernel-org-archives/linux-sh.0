From: Baruch Siach <baruch@tkos.co.il>
Date: Wed, 05 Feb 2014 19:28:38 +0000
Subject: [PATCH] serial: sh_sci: remove HAVE_CLK build dependecy
Message-Id: <2f1dd25b19bf588948fbebc734eebe5d61ca7007.1391628518.git.baruch@tkos.co.il>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>

Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h
like this driver needs not depend on HAVE_CLK.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a3815eaed421..ce6fd1dd0864 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -708,7 +708,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on HAVE_CLK && (SUPERH || ARM || COMPILE_TEST)
+	depends on SUPERH || ARM || COMPILE_TEST
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
-- 
1.8.5.3

