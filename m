From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 28 Jul 2008 20:17:05 +0000
Subject: [2.6 patch] SH_AP325RXA must select I2C
Message-Id: <20080728201705.GC7713@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, Yusuke Goda <goda.yusuke@renesas.com>, Magnus Damm <damm@igel.co.jp>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following build error:

<--  snip  -->

...
  LD      vmlinux
arch/sh/boards/renesas/ap325rxa/built-in.o: In function `camera_set_capture':
setup.c:(.text+0x80): undefined reference to `i2c_get_adapter'
setup.c:(.text+0x88): undefined reference to `i2c_transfer'
make[1]: *** [vmlinux] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
cdcb22706c51f0ae44946f4c3826cc3658960eba 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7bfb0d2..6f77d0a 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -520,6 +520,7 @@ config SH_MIGOR
 config SH_AP325RXA
 	bool "AP-325RXA"
 	depends on CPU_SUBTYPE_SH7723
+	select I2C
 	help
 	  Renesas "AP-325RXA" support.
 	  Compatible with ALGO SYSTEM CO.,LTD. "AP-320A"

