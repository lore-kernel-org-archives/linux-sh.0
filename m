From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Nov 2013 10:08:59 +0000
Subject: [PATCH] sh: sh7757lcr: fixup SDHI register size
Message-Id: <87mwl7z45k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-kernel@vger.kernel.org

sh7757lcr SDHI register size is 0x100

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Hi Simon, and Linux ML

This patch is bug fix for arch/sh,
but, there is no SH maintainer today.
So, I don't know who can care this.

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

