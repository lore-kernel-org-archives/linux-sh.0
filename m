From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 18:55:54 +0000
Subject: [PATCH 2/2] sh/intc: Delete an error message for a failed memory allocation in add_virq_to_pirq()
Message-Id: <54e30d61-5183-9911-cf35-1410fb78da5a@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
References: <e24933d7-b887-e443-af74-327a2d37d6fa@users.sourceforge.net>
In-Reply-To: <e24933d7-b887-e443-af74-327a2d37d6fa@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 20:23:43 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/sh/intc/virq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/sh/intc/virq.c b/drivers/sh/intc/virq.c
index 2079425c95ed..79d733f3411a 100644
--- a/drivers/sh/intc/virq.c
+++ b/drivers/sh/intc/virq.c
@@ -97,7 +97,5 @@ static int add_virq_to_pirq(unsigned int irq, unsigned int virq)
-	if (!entry) {
-		pr_err("can't allocate VIRQ mapping for %d\n", virq);
+	if (!entry)
 		return -ENOMEM;
-	}
 
 	entry->irq = virq;
 
-- 
2.13.0

