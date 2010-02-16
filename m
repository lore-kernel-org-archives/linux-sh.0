From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Feb 2010 10:53:15 +0000
Subject: [PATCH] input: enable sh_keysc on SH-Mobile ARM
Message-Id: <20100216105315.15440.95212.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-input@vger.kernel.org
Cc: lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, dmitry.torokhov@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the Kconfig entry for the sh_keysc driver to
enable build on SH-Mobile ARM platforms.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/input/keyboard/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/input/keyboard/Kconfig
+++ work/drivers/input/keyboard/Kconfig	2010-02-16 19:35:04.000000000 +0900
@@ -363,7 +363,7 @@ config KEYBOARD_SUNKBD
 
 config KEYBOARD_SH_KEYSC
 	tristate "SuperH KEYSC keypad support"
-	depends on SUPERH
+	depends on SUPERH || ARCH_SHMOBILE
 	help
 	  Say Y here if you want to use a keypad attached to the KEYSC block
 	  on SuperH processors such as sh7722 and sh7343.
