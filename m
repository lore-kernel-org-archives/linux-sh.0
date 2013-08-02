From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 01:33:38 +0000
Subject: [PATCH 1/4] ARM: shmobile: r8a7779: add missing __initdata
Message-Id: <87vc3o98r5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87391lwwbk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87391lwwbk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index ddee4aa..6095ab3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -537,7 +537,7 @@ static struct platform_device ohci1_device = {
 };
 
 /* Ether */
-static struct resource ether_resources[] = {
+static struct resource ether_resources[] __initdata = {
 	{
 		.start	= 0xfde00000,
 		.end	= 0xfde003ff,
-- 
1.7.9.5

