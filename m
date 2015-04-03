From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 03 Apr 2015 12:41:58 +0000
Subject: [PATCH 1/6] Revert "staging: board: disable as it breaks the build"
Message-Id: <1428064923-24950-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This reverts commit d13778d537a0ed6115d2a79a942af999cfb8eec6.

Commit 13c11072536f2613 ("staging:board: remove unnecessary function")
fixed the build of drivers/staging/board/board.c.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/staging/board/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/board/Kconfig b/drivers/staging/board/Kconfig
index 0a89ad16371f7ded..b8ee81840666ad35 100644
--- a/drivers/staging/board/Kconfig
+++ b/drivers/staging/board/Kconfig
@@ -1,7 +1,6 @@
 config STAGING_BOARD
 	bool "Staging Board Support"
 	depends on OF_ADDRESS
-	depends on BROKEN
 	help
 	  Select to enable per-board staging support code.
 
-- 
1.9.1

