From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 04 Mar 2014 18:11:15 +0000
Subject: [PATCH] ARM: shmobile: APMU: Fix warnings due to improper printk formats
Message-Id: <1393956675-10701-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use the %pr printk specifier to print resource variables. This fixes
warnings on platforms where resource_size_t has a different size than
int.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 1da5a72..8cb641c 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -75,8 +75,7 @@ static void apmu_init_cpu(struct resource *res, int cpu, int bit)
 	apmu_cpus[cpu].iomem = ioremap_nocache(res->start, resource_size(res));
 	apmu_cpus[cpu].bit = bit;
 
-	pr_debug("apmu ioremap %d %d 0x%08x 0x%08x\n", cpu, bit,
-		 res->start, resource_size(res));
+	pr_debug("apmu ioremap %d %d %pr\n", cpu, bit, res);
 }
 
 static struct {
-- 
Regards,

Laurent Pinchart

