From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 08 Apr 2013 02:49:17 +0000
Subject: [RFC][PATCH] sh-pfc: r8a7779: tidyup intc_irq3_b typo
Message-Id: <87obdpohxx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Laurent

Now, I'm studying about sh pinctrol code.
So, I can't have firm belief about this patch.
But maybe it was typo

 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 62dcdcd..791a671 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2552,7 +2552,7 @@ static const char * const intc_groups[] = {
 	"intc_irq2",
 	"intc_irq2_b",
 	"intc_irq3",
-	"intc_irq4_b",
+	"intc_irq3_b",
 };
 
 static const char * const lbsc_groups[] = {
-- 
1.7.9.5

