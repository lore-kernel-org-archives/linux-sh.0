From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2015 08:38:51 +0000
Subject: [PATCH v2 2/7] staging: board: Initialize staging board code earlier
Message-Id: <1434530336-15073-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Currently the staging board code is initialized from a late_initcall().
However, unused PM domains are also disabled from a late_initcall(),
which happens before due to link order.

Change the initialization of staging board code from using
late_initcall() to device_initcall() to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop RFC status.
---
 drivers/staging/board/board.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
index 2390ed6c31a42f2f..e9c914985d4acb36 100644
--- a/drivers/staging/board/board.h
+++ b/drivers/staging/board/board.h
@@ -15,6 +15,6 @@ static int __init runtime_board_check(void)	\
 	return 0;				\
 }						\
 						\
-late_initcall(runtime_board_check)
+device_initcall(runtime_board_check)
 
 #endif /* __BOARD_H__ */
-- 
1.9.1

