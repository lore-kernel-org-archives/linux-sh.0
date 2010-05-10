From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Mon, 10 May 2010 11:50:55 +0000
Subject: [PATCH 1/1] sh: clkfwk: Use debugfs_remove_recursive() for rewinding
Message-Id: <1273492255-5158-1-git-send-email-Hiroshi.DOYU@nokia.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Rewinding each debugfs entries to unregister if an error happens.

Based on the commit ca4caa4e1d45f9542fa54263974d0ef637157b4a

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/sh/kernel/cpu/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index e9fa1bf..551b214 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -673,7 +673,7 @@ static int __init clk_debugfs_init(void)
 	}
 	return 0;
 err_out:
-	debugfs_remove(clk_debugfs_root); /* REVISIT: Cleanup correctly */
+	debugfs_remove_recursive(clk_debugfs_root);
 	return err;
 }
 late_initcall(clk_debugfs_init);
-- 
1.7.1.rc1

