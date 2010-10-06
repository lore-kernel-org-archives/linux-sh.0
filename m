From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 06 Oct 2010 07:57:40 +0000
Subject: [PATCH] sh: Fix multiple definition of intc_balancing_enable
Message-Id: <1286351860-18777-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If CONFIG_INTC_BALANCING is not defined, intc_balancing_disable and
other are defined multiple.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/sh/intc/internals.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
index f02a47f..8799d35 100644
--- a/drivers/sh/intc/internals.h
+++ b/drivers/sh/intc/internals.h
@@ -143,9 +143,9 @@ void intc_balancing_disable(unsigned int irq);
 void intc_set_dist_handle(unsigned int irq, struct intc_desc *desc,
 			  struct intc_desc_int *d, intc_enum id);
 #else
-void intc_balancing_enable(unsigned int irq) { }
-void intc_balancing_disable(unsigned int irq) { }
-void intc_set_dist_handle(unsigned int irq, struct intc_desc *desc,
+static inline void intc_balancing_enable(unsigned int irq) { }
+static inline void intc_balancing_disable(unsigned int irq) { }
+static inline void intc_set_dist_handle(unsigned int irq, struct intc_desc *desc,
 			  struct intc_desc_int *d, intc_enum id) { }
 #endif
 
-- 
1.7.1

