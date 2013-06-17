From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 17 Jun 2013 09:28:49 +0000
Subject: [PATCH 3/3] ARM: shmobile: r8a7790: don't use external clock for SCIFs
Message-Id: <1371461329-26467-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371461329-26467-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1371461329-26467-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht@gmail.com>

This is an external component and may or may not be there, while the
internal clock always works.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 896d374..6531f3d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -64,7 +64,7 @@ void __init r8a7790_pinmux_init(void)
 [index] = {						\
 	SCIF_COMMON(PORT_SCIF, baseaddr, irq),		\
 	.scbrr_algo_id	= SCBRR_ALGO_2,			\
-	.scscr = SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
+	.scscr = SCSCR_RE | SCSCR_TE,	\
 }
 
 #define HSCIF_DATA(index, baseaddr, irq)		\
-- 
1.7.10.4

