From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sun, 01 Feb 2009 07:58:45 +0000
Subject: [PATCH] qemu-sh : pci nic interface modified
Message-Id: <49855635.1090108@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

QEMU revision 6287 modifies pci nic interface. As a result,
'sh4-r2d-update-pci-usb-and-kernel-management.patch' does not apply
smoothly.  This patch solves it.


Signed-off-by: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp> 

diff --git a/staging/sh4-r2d-update-pci-usb-and-kernel-management.patch b/staging/sh4-r2d-update-pci-usb-and-kernel-management.patch
index 6ff42e0..9017909 100644
--- a/staging/sh4-r2d-update-pci-usb-and-kernel-management.patch
+++ b/staging/sh4-r2d-update-pci-usb-and-kernel-management.patch
@@ -28,11 +28,11 @@ Index: qemu/hw/r2d.c
 +    pci = sh_pci_register_bus(r2d_pci_set_irq, r2d_pci_map_irq, irq, 0, 4);
  
      /* NIC: rtl8139 on-board, and 2 slots. */
--    pci_rtl8139_init(pci, &nd_table[0], 2 << 3);
+-    pci_nic_init(pci, &nd_table[0], 2 << 3, "rtl8139");
 +    if (nb_nics)
-+        pci_rtl8139_init(pci, &nd_table[0], 2 << 3);
++        pci_nic_init(pci, &nd_table[0], 2 << 3, "rtl8139");
      for (i = 1; i < nb_nics; i++)
-         pci_nic_init(pci, &nd_table[i], -1);
+         pci_nic_init(pci, &nd_table[i], -1, "ne2k_pci");
  
 +    /* USB OHCI for keyboard & mouse */
 +    if (usb_enabled)
