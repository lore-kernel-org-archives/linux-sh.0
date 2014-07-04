From: Fabian Frederick <fabf@skynet.be>
Date: Fri, 04 Jul 2014 20:07:09 +0000
Subject: [PATCH 1/1] arch/sh/mm/asids-debugfs.c: use PTR_ERR_OR_ZERO
Message-Id: <1404504429-602-1-git-send-email-fabf@skynet.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org

replace IS_ERR/PTR_ERR

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---

This is untested.

 arch/sh/mm/asids-debugfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/mm/asids-debugfs.c b/arch/sh/mm/asids-debugfs.c
index 74c03ec..ecfc6b0 100644
--- a/arch/sh/mm/asids-debugfs.c
+++ b/arch/sh/mm/asids-debugfs.c
@@ -67,10 +67,8 @@ static int __init asids_debugfs_init(void)
 					   NULL, &asids_debugfs_fops);
 	if (!asids_dentry)
 		return -ENOMEM;
-	if (IS_ERR(asids_dentry))
-		return PTR_ERR(asids_dentry);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(asids_dentry);
 }
 module_init(asids_debugfs_init);
 
-- 
1.9.1

