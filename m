From: Allen Pais <allen.lkml@gmail.com>
Date: Fri, 22 Sep 2017 11:56:11 +0000
Subject: [PATCH 2/2] sh: pci: use setup_timer() helper.
Message-Id: <1506081360-6555-2-git-send-email-allen.lkml@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 arch/sh/drivers/pci/common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index dbf1381..5f4b3a8 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -105,15 +105,13 @@ static void pcibios_enable_serr(unsigned long __data)
 void pcibios_enable_timers(struct pci_channel *hose)
 {
 	if (hose->err_irq) {
-		init_timer(&hose->err_timer);
-		hose->err_timer.data = (unsigned long)hose;
-		hose->err_timer.function = pcibios_enable_err;
+		setup_timer(&hose->err_timer, pcibios_enable_err,
+			    (unsigned long)hose);
 	}
 
 	if (hose->serr_irq) {
-		init_timer(&hose->serr_timer);
-		hose->serr_timer.data = (unsigned long)hose;
-		hose->serr_timer.function = pcibios_enable_serr;
+		setup_timer(&hose->serr_timer, pcibios_enable_serr,
+			    (unsigned long)hose);
 	}
 }
 
-- 
2.7.4

