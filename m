From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 31 May 2013 15:57:04 +0000
Subject: [PATCH v3 4/5] ARM: shmobile: r8a7790: don't use external clock for SCIFs
Message-Id: <1370015825-29383-5-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is an external component and may or may not be there, while the
internal clock always works.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/mach-shmobile/setup-r8a7790.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 5b7a770..a380bdc 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -96,7 +96,7 @@ void __init r8a7790_pinmux_init(void)
 [index] = {						\
 	SCIF_COMMON(PORT_SCIF, baseaddr, irq),		\
 	.scbrr_algo_id	= SCBRR_ALGO_2,			\
-	.scscr = SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
+	.scscr = SCSCR_RE | SCSCR_TE,	\
 }
 
 #define HSCIF_DATA(index, baseaddr, irq)		\
-- 
1.7.10.4

