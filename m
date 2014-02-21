From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 21 Feb 2014 00:20:17 +0000
Subject: [PATCH][RESENT] sh: sh7757lcr: fixup SDHI register size
Message-Id: <87a9dlqptu.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-kernel@vger.kernel.org

sh7757lcr SDHI register size is 0x100

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon, Geert, Andrew

Now, no-one is maintenance SH patch.
Who can apply this patch ??

 arch/sh/boards/board-sh7757lcr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 25c5a93..669df51 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -252,7 +252,7 @@ static struct sh_mobile_sdhi_info sdhi_info = {
 static struct resource sdhi_resources[] = {
 	[0] = {
 		.start  = 0xffe50000,
-		.end    = 0xffe501ff,
+		.end    = 0xffe500ff,
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-- 
1.7.9.5

