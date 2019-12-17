From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Dec 2019 07:50:36 +0000
Subject: [PATCH v2] SH: Convert iounmap() macros to inline functions
Message-Id: <877e2vgzlf.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Macro iounmap() do nothing, but that results in
unused variable warnings all over the place.
This patch convert it to inline to avoid warning

We will get this kind of warning without this patch

	${LINUX}/drivers/thermal/broadcom/ns-thermal.c:78:21: \
	  warning: unused variable 'ns_thermal' [-Wunused-variable]
	struct ns_thermal *ns_thermal = platform_get_drvdata(pdev);
	^~~~~~~~~~

Fixes: 98c90e5ea34e9 ("sh: remove __iounmap")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
v1 -> v2

	- add warning on git-log

 arch/sh/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 1495489..351a0a9 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -328,7 +328,7 @@ __ioremap_mode(phys_addr_t offset, unsigned long size, pgprot_t prot)
 #else
 #define __ioremap(offset, size, prot)		((void __iomem *)(offset))
 #define __ioremap_mode(offset, size, prot)	((void __iomem *)(offset))
-#define iounmap(addr)				do { } while (0)
+static inline void iounmap(void __iomem *addr) {}
 #endif /* CONFIG_MMU */
 
 static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
-- 
2.7.4
