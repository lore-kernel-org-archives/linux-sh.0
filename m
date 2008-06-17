From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 17 Jun 2008 22:31:03 +0000
Subject: [2.6 patch] sh: make EARLY_PCI_OP's static
Message-Id: <20080617223103.GL25911@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch makes the needlessly global EARLY_PCI_OP's static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
bc7fc605abf94396ac4b30eaa5270e0f42d15924 diff --git a/arch/sh/drivers/pci/pci-auto.c b/arch/sh/drivers/pci/pci-auto.c
index ea40470..cf48b12 100644
--- a/arch/sh/drivers/pci/pci-auto.c
+++ b/arch/sh/drivers/pci/pci-auto.c
@@ -78,7 +78,7 @@ static struct pci_dev *fake_pci_dev(struct pci_channel *hose,
 }
 
 #define EARLY_PCI_OP(rw, size, type)					\
-int early_##rw##_config_##size(struct pci_channel *hose,		\
+static int early_##rw##_config_##size(struct pci_channel *hose,		\
 	int top_bus, int bus, int devfn, int offset, type value)	\
 {									\
 	return pci_##rw##_config_##size(				\

