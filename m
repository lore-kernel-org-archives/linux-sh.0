From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 06 Dec 2013 09:59:43 +0000
Subject: [PATCH 36/47] ARM: shmobile: r8a7740: Don't set plat_sci_port scbrr_algo_id field
Message-Id: <1386323994-12850-37-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 81a4366..8f3c681 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -208,7 +208,6 @@ static struct platform_device irqpin3_device = {
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.type		= scif_type,				\
 	.flags		= UPF_BOOT_AUTOCONF,			\
-	.scbrr_algo_id	= SCBRR_ALGO_4,				\
 	.scscr		= SCSCR_RE | SCSCR_TE,			\
 };								\
 								\
-- 
1.8.3.2

