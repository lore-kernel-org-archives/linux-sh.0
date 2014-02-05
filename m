From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 10:19:03 +0000
Subject: FYI: current usb patches
Message-Id: <1391595554-20640-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is the current set of patches I have to get USB working on the
Lager board with FDT support. Please let me know if I have missed
anything or if there are new review comments.

Magnus, if you would like these rebased ontop of your bridge changes
then let me know and I will sort that out.

[PATCH 01/11] pci-rcar-gen2: add of match table
[PATCH 02/11] pci-rcar-gen2: add initial device tree documentation
[PATCH 03/11] ARM: shmbobile: r8a7790.dtsi: add pci0/1/2 nodes
[PATCH 04/11] ARM: shmobile: lager.dts: add pci 0/1/2
[PATCH 05/11] phy-rcar-usb-gen2: add device tree support
[PATCH 06/11] phy-rcar-usb-gen2: add device tree documentation
[PATCH 07/11] ARM: shmobile: r8a7790.dtsi: add usbphy node
[PATCH 08/11] ARM: shmobile: lager.dtb: add usbphy reference
[PATCH 09/11] PCI: rcar: check platform_get_irq() return code
[PATCH 10/11] PCI: rcar: add error interrupt handling
[PATCH 11/11] PCI: rcar: fix bridge logic configuration accesses
