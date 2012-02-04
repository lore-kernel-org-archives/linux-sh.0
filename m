From: Masanari Iida <standby24x7@gmail.com>
Date: Sat, 04 Feb 2012 12:40:24 +0000
Subject: [PATCH] [trivial] sh: Fix typo in pci-sh7780.c
Message-Id: <1328359224-1724-1-git-send-email-standby24x7@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, standby24x7@gmail.com

Correct spelling "erorr" to "error" in
arch/sh/drivers/pci/pci-sh7780.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/sh/drivers/pci/pci-sh7780.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index fa7b978..fb8f1499 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -74,7 +74,7 @@ struct pci_errors {
 	{ SH4_PCIINT_MLCK,	"master lock error" },
 	{ SH4_PCIINT_TABT,	"target-target abort" },
 	{ SH4_PCIINT_TRET,	"target retry time out" },
-	{ SH4_PCIINT_MFDE,	"master function disable erorr" },
+	{ SH4_PCIINT_MFDE,	"master function disable error" },
 	{ SH4_PCIINT_PRTY,	"address parity error" },
 	{ SH4_PCIINT_SERR,	"SERR" },
 	{ SH4_PCIINT_TWDP,	"data parity error for target write" },
-- 
1.7.6.5

