From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Feb 2008 14:54:23 +0000
Subject: [PATCH] sh: add sh7722 support to EARLY_SCIF_CONSOLE
Message-Id: <20080206145423.27046.98635.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds the base address of SCIF0 in the case of sh7722.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/sh/Kconfig.debug
+++ work/arch/sh/Kconfig.debug	2008-02-06 21:11:08.000000000 +0900
@@ -30,6 +30,7 @@ config EARLY_SCIF_CONSOLE_PORT
 	hex
 	depends on EARLY_SCIF_CONSOLE
  	default "0xffe00000" if CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7763
+ 	default "0xffe00000" if CPU_SUBTYPE_SH7722
 	default "0xffea0000" if CPU_SUBTYPE_SH7785
 	default "0xfffe8000" if CPU_SUBTYPE_SH7203
 	default "0xfffe9800" if CPU_SUBTYPE_SH7206 || CPU_SUBTYPE_SH7263
