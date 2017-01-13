From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 09:49:30 +0000
Subject: [PATCH 2/3] sh/intc: Combine substrings for a message in register_intc_controller()
Message-Id: <3a14a1b0-bf12-8e88-935c-732d21fa1189@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4d37c4d8-d28b-bd98-968b-f544d6a213eb@users.sourceforge.net>
In-Reply-To: <4d37c4d8-d28b-bd98-968b-f544d6a213eb@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 10:16:40 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/sh/intc/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 27817a8466f1..95fb29d69ab7 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -353,8 +353,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 					res = irq_domain_associate(d->domain,
 								   irq2, irq2);
 					if (unlikely(res)) {
-						pr_err("domain association "
-						       "failure\n");
+						pr_err("domain association failure\n");
 						continue;
 					}
 				} else {
-- 
2.11.0

