From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Date: Mon, 13 Jul 2020 12:22:37 +0000
Subject: [RFC PATCH 25/35] sh: Tidy Success/Failure checks
Message-Id: <20200713122247.10985-26-refactormyself@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200713122247.10985-1-refactormyself@gmail.com>
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: helgaas@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, "Saheed O. Bolarinwa" <refactormyself@gmail.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 24/35

 arch/sh/drivers/pci/common.c     | 3 +--
 arch/sh/drivers/pci/ops-sh7786.c | 4 ++--
 arch/sh/drivers/pci/pci.c        | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index ee27cdfd3e68..676907e6a514 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -60,8 +60,7 @@ int __init pci_is_66mhz_capable(struct pci_channel *hose,
 		if (PCI_FUNC(pci_devfn))
 			continue;
 		if (early_read_config_word(hose, top_bus, current_bus,
-					   pci_devfn, PCI_VENDOR_ID, &vid) !-		    0)
+					   pci_devfn, PCI_VENDOR_ID, &vid))
 			continue;
 		if (vid = 0xffff)
 			continue;
diff --git a/arch/sh/drivers/pci/ops-sh7786.c b/arch/sh/drivers/pci/ops-sh7786.c
index 7c329e467360..c1be0ac2508a 100644
--- a/arch/sh/drivers/pci/ops-sh7786.c
+++ b/arch/sh/drivers/pci/ops-sh7786.c
@@ -101,7 +101,7 @@ static int sh7786_pcie_read(struct pci_bus *bus, unsigned int devfn,
 	raw_spin_lock_irqsave(&pci_config_lock, flags);
 	ret = sh7786_pcie_config_access(PCI_ACCESS_READ, bus,
 					devfn, where, &data);
-	if (ret != 0) {
+	if (ret) {
 		*val = 0xffffffff;
 		goto out;
 	}
@@ -137,7 +137,7 @@ static int sh7786_pcie_write(struct pci_bus *bus, unsigned int devfn,
 	raw_spin_lock_irqsave(&pci_config_lock, flags);
 	ret = sh7786_pcie_config_access(PCI_ACCESS_READ, bus,
 					devfn, where, &data);
-	if (ret != 0)
+	if (ret)
 		goto out;
 
 	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x "
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 77130f035fdd..19e9a211c23e 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -204,7 +204,7 @@ pcibios_bus_report_status_early(struct pci_channel *hose,
 			continue;
 		ret = early_read_config_word(hose, top_bus, current_bus,
 					     pci_devfn, PCI_STATUS, &status);
-		if (ret != 0)
+		if (ret)
 			continue;
 		if (status = 0xffff)
 			continue;
-- 
2.18.2
