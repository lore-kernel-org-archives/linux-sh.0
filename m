From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 21:43:24 +0000
Subject: [PATCH 10/16] ARM: shmobile: r8a7778: Don't set plat_sci_port scbrr_algo_id field
Message-Id: <1385675010-26904-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org

The field will be removed from the sh-sci driver. Don't set it and let
the driver handle baud rate calculation internally.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 47c8230..855e2f3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -48,7 +48,6 @@
 static struct plat_sci_port scif##index##_platform_data = {	\
 	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,	\
-	.scbrr_algo_id	= SCBRR_ALGO_2,				\
 	.type		= PORT_SCIF,				\
 };								\
 								\
-- 
1.8.3.2

