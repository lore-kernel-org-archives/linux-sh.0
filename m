From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 24 Dec 2013 14:16:04 +0000
Subject: [PATCH 24/29] ARM: shmobile: r8a73a4: Don't set plat_sci_port scbrr_algo_id field
Message-Id: <720938a10519cc2511199d4eab7e885f214c10f6.1387888861.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a73a4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index ef32ce2..cd36f80 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -44,7 +44,6 @@ void __init r8a73a4_pinmux_init(void)
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= scif_type,				\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
-	.scbrr_algo_id	= SCBRR_ALGO_4,				\
 	.scscr		= _scscr,				\
 };								\
 								\
-- 
1.8.4

