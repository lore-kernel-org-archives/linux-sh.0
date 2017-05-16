From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 18:54:29 +0000
Subject: [PATCH 1/2] sh/intc: Improve a size determination in add_virq_to_pirq()
Message-Id: <359e6a4f-66e3-87a2-0c55-8d57e9d1101f@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
References: <e24933d7-b887-e443-af74-327a2d37d6fa@users.sourceforge.net>
In-Reply-To: <e24933d7-b887-e443-af74-327a2d37d6fa@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 19:56:47 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/sh/intc/virq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/intc/virq.c b/drivers/sh/intc/virq.c
index 35bbe288ddb4..2079425c95ed 100644
--- a/drivers/sh/intc/virq.c
+++ b/drivers/sh/intc/virq.c
@@ -93,5 +93,5 @@ static int add_virq_to_pirq(unsigned int irq, unsigned int virq)
 		last = &entry->next;
 	}
 
-	entry = kzalloc(sizeof(struct intc_virq_list), GFP_ATOMIC);
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 	if (!entry) {
-- 
2.13.0

