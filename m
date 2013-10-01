From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 01 Oct 2013 02:35:53 +0000
Subject: [PATCH 14/14] ARM: shmobile: Include CA7 cores in APMU table
Message-Id: <43651b15de94d6a5e188ea032311e9661ec708d2.1380532277.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1380532277.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1380532277.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add information to the shared APMU code regarding
the APMU instance used to control the CA7 cores.

This can be used on r8a7790 and r8a73a4, but should
most likely be converted to DT in the future.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index caaaa35..1da5a72 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -86,6 +86,10 @@ static struct {
 	{
 		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
 		.cpus = { 0, 1, 2, 3 },
+	},
+	{
+		.iomem = DEFINE_RES_MEM(0xe6151000, 0x88),
+		.cpus = { 0x100, 0x101, 0x102, 0x103 },
 	}
 };
 
-- 
1.8.4

