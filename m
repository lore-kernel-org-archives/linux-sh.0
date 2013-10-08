From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 05:59:06 +0000
Subject: [PATCH 6/7] ARM: shmobile: sh73a0: don't use named resource for IPMMU
Message-Id: <87y564wbfc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

shmobile-ipmmu driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index c515801..65151c4 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -722,7 +722,7 @@ static struct platform_device pmu_device = {
 
 /* an IPMMU module for ICB */
 static struct resource ipmmu_resources[] = {
-	DEFINE_RES_MEM_NAMED(0xfe951000, 0x100, "IPMMU"),
+	DEFINE_RES_MEM(0xfe951000, 0x100),
 };
 
 static const char * const ipmmu_dev_names[] = {
-- 
1.7.9.5

