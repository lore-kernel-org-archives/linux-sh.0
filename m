From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Aug 2013 04:38:36 +0000
Subject: [GIT PULL 19/26] ARM: shmobile: r8a7779: add missing __initdata
Message-Id: <c7537655c6ce1d769bd6d4ec368cdf8c36ebb6ea.1375840527.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 111e953..f0b6c7d 100644
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
1.8.3.2

