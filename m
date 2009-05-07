From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 May 2009 10:17:44 +0000
Subject: [PATCH] sh: sh7785 early scif fix
Message-Id: <20090507101744.31631.58621.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch moves the SH4 case of EARLY_SCIF_CONSOLE_PORT
so the SH7785 default value gets used. Without this patch
the value for SH7785 is set to 0xffe80000.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/Kconfig.debug
+++ work/arch/sh/Kconfig.debug	2009-05-07 17:47:37.000000000 +0900
@@ -38,10 +38,10 @@ config EARLY_SCIF_CONSOLE_PORT
 	default "0xffe00000" if CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7763 || \
 				CPU_SUBTYPE_SH7722 || CPU_SUBTYPE_SH7366 || \
 				CPU_SUBTYPE_SH7343
-	default "0xffe80000" if CPU_SH4
 	default "0xffea0000" if CPU_SUBTYPE_SH7785
 	default "0xfffe8000" if CPU_SUBTYPE_SH7203
 	default "0xfffe9800" if CPU_SUBTYPE_SH7206 || CPU_SUBTYPE_SH7263
+	default "0xffe80000" if CPU_SH4
 	default "0x00000000"
 
 config EARLY_PRINTK
