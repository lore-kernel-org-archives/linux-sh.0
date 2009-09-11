From: Yusuke Goda <goda.yusuke@renesas.com>
Date: Fri, 11 Sep 2009 02:42:46 +0000
Subject: [PATCH] sh: Fix the indication point of the liquid crystal of
Message-Id: <4AA9B926.9090907@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yusuke Goda <goda.yusuke@renesas.com>
---
 arch/sh/boards/board-ap325rxa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index 19eea4a..bcf1f40 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -188,7 +188,7 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.name = "LB070WV1",
 			.xres = 800,
 			.yres = 480,
-			.left_margin = 40,
+			.left_margin = 32,
 			.right_margin = 160,
 			.hsync_len = 8,
 			.upper_margin = 63,
-- 
1.6.0.4


