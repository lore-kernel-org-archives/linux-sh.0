From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Dec 2009 13:38:52 +0000
Subject: [PATCH] sh: fix sh7724 VEU3F resource size
Message-Id: <20091201133852.29252.62066.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix one-off VEU3F size error for sh7724.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-12-01 21:17:58.000000000 +0900
@@ -204,7 +204,7 @@ static struct resource veu0_resources[] 
 	[0] = {
 		.name	= "VEU3F0",
 		.start	= 0xfe920000,
-		.end	= 0xfe9200cb - 1,
+		.end	= 0xfe9200cb,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -236,7 +236,7 @@ static struct resource veu1_resources[] 
 	[0] = {
 		.name	= "VEU3F1",
 		.start	= 0xfe924000,
-		.end	= 0xfe9240cb - 1,
+		.end	= 0xfe9240cb,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
