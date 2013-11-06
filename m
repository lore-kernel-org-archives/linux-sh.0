From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 06 Nov 2013 06:48:43 +0000
Subject: [PATCH] ARM: shmobile: r8a7779: Remove unused clock constants
Message-Id: <1383720523-9645-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehmifl3b.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehmifl3b.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index b7ce0e7..3083c70 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -47,17 +47,9 @@
 
 #define MD(nr)	BIT(nr)
 
-#define FRQMR		IOMEM(0xffc80014)
 #define MSTPCR0		IOMEM(0xffc80030)
 #define MSTPCR1		IOMEM(0xffc80034)
 #define MSTPCR3		IOMEM(0xffc8003c)
-#define MSTPSR1		IOMEM(0xffc80044)
-#define MSTPSR4		IOMEM(0xffc80048)
-#define MSTPSR6		IOMEM(0xffc8004c)
-#define MSTPCR4		IOMEM(0xffc80050)
-#define MSTPCR5		IOMEM(0xffc80054)
-#define MSTPCR6		IOMEM(0xffc80058)
-#define MSTPCR7		IOMEM(0xffc80040)
 
 #define MODEMR		0xffcc0020
 
-- 
1.8.4

