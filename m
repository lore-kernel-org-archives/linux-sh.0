From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 00:33:52 +0000
Subject: [PATCH 4/6] ARM: shmobile: apmu: correct type of CPU id
Message-Id: <6e67d2ccb8b5ac6dbc6a0cfdf8320d68fa289193.1444868660.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1444868660.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1444868660.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Andrzej Hajda <a.hajda@samsung.com>

CPU id can be negative, so it cannot be assigned to unsigned variable.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index bcf4cc51b926..911884f7e28b 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -88,7 +88,7 @@ static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 static void apmu_parse_cfg(void (*fn)(struct resource *res, int cpu, int bit),
 			   struct rcar_apmu_config *apmu_config, int num)
 {
-	u32 id;
+	int id;
 	int k;
 	int bit, index;
 	bool is_allowed;
-- 
2.1.4

