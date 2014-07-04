From: Fabian Frederick <fabf@skynet.be>
Date: Fri, 04 Jul 2014 18:47:28 +0000
Subject: [PATCH 1/1] arch/sh/kernel/time.c: use PTR_ERR_OR_ZERO
Message-Id: <1404499648-14414-1-git-send-email-fabf@skynet.be>
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

 arch/sh/kernel/time.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index 552c8fc..d6d0a98 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -80,10 +80,8 @@ static int __init rtc_generic_init(void)
 		return -ENODEV;
 
 	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 module_init(rtc_generic_init);
 
-- 
1.9.1

