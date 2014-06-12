From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Jun 2014 08:42:23 +0000
Subject: [PATCH 2/3] ARM: shmobile: rcar-gen2: Use "1ULL" instead of "(u64)1"
Message-Id: <1402562544-4527-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Casts are evil

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 1c09789393cd..e308bdb9ae4d 100644
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
1.9.1

