From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 25 Jun 2014 07:35:22 +0000
Subject: [PATCH 10/14] ARM: shmobile: rcar-gen2: Use "1ULL" instead of "(u64)1"
Message-Id: <b69f47c00f2eff19b532cf0142d81b993e587bf0.1403681315.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Casts are evil

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index b0626f8..51d5723 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -126,7 +126,7 @@ static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
 	const __be32 *reg, *endp;
 	int l;
 	struct memory_reserve_config *mrc = data;
-	u64 lpae_start = (u64)1 << 32;
+	u64 lpae_start = 1ULL << 32;
 
 	/* We are scanning "memory" nodes only */
 	if (type = NULL) {
-- 
2.0.0.rc2

