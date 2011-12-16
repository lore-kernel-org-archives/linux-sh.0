From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 16 Dec 2011 22:31:44 +0000
Subject: [PATCH 3/6] sh/PCI: use list_for_each_entry() for bus->devices
Message-Id: <20111216223144.5963.48685.stgit@bhelgaas.mtv.corp.google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Replace open-coded list traversal with list_for_each_entry().

CC: Paul Mundt <lethal@linux-sh.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/sh/drivers/pci/pci.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index af9246d..e425b08 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -171,11 +171,8 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev,
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-	struct list_head *ln;
-
-	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-		dev = pci_dev_b(ln);
 
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 			pcibios_fixup_device_resources(dev, bus);
 	}

