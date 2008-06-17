From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 17 Jun 2008 22:33:40 +0000
Subject: [2.6 patch] sh: make pcibios_max_latency static
Message-Id: <20080617223340.GN25911@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch makes the needlessly global pcibios_max_latency static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
68ca774cb5441d414e0bbb837bfc35488bf68bd6 diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index f57095a..d3839e6 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -135,7 +135,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
  *  If we set up a device for bus mastering, we need to check and set
  *  the latency timer as it may not be properly set.
  */
-unsigned int pcibios_max_latency = 255;
+static unsigned int pcibios_max_latency = 255;
 
 void pcibios_set_master(struct pci_dev *dev)
 {

