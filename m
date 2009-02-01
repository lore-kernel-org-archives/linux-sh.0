From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sun, 01 Feb 2009 07:59:58 +0000
Subject: [PATCH] qemu-sh : pci_sh patch accepted
Message-Id: <49855681.1030200@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Aurelian Jarno kindly applied Yoshii-san's patch to QEMU trunk,
at revision 6433. This patch removes it from qemu-sh repository.

Signed-off-by: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp> 


diff --git a/series b/series
index 1212b52..533b1aa 100644
--- a/series
+++ b/series
@@ -2,7 +2,6 @@
 # General architecture patches
 #
 staging/sh7750-51-add-register-bcr3-ncr4-pcr-rtcor-rtcn.patch
-staging/sh_pci-register-resources-both-at-a7-and-p4.patch
 
 #
 # Board support improvements
diff --git a/staging/sh_pci-register-resources-both-at-a7-and-p4.patch b/staging/sh_pci-register-resources-both-at-a7-and-p4.patch
deleted file mode 100644
index 46eb8e0..0000000
--- a/staging/sh_pci-register-resources-both-at-a7-and-p4.patch
+++ /dev/null
@@ -1,53 +0,0 @@
-Add resource registration both for P4 and A7.
-This is needed because of #5935 SH4: Eliminate P4 to A7 mangling.
-Additionally, {reg,iop,mem}base which is no longer used are removed.
-
-Signed-off-by: Takashi YOSHII <takasi-y@ops.dti.ne.jp>
----
- hw/sh_pci.c |   17 +++++++----------
- 1 files changed, 7 insertions(+), 10 deletions(-)
-
-diff --git a/hw/sh_pci.c b/hw/sh_pci.c
-index 5524c59..9f89f2d 100644
---- a/hw/sh_pci.c
-+++ b/hw/sh_pci.c
-@@ -29,9 +29,6 @@
- typedef struct {
-     PCIBus *bus;
-     PCIDevice *dev;
--    uint32_t regbase;
--    uint32_t iopbase;
--    uint32_t membase;
-     uint32_t par;
-     uint32_t mbr;
-     uint32_t iobr;
-@@ -181,15 +178,15 @@ PCIBus *sh_pci_register_bus(pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
- 
-     p->dev = pci_register_device(p->bus, "SH PCIC", sizeof(PCIDevice),
-                                  -1, NULL, NULL);
--    p->regbase = 0x1e200000;
--    p->iopbase = 0x1e240000;
--    p->membase = 0xfd000000;
-     reg = cpu_register_io_memory(0, sh_pci_reg.r, sh_pci_reg.w, p);
--    mem = cpu_register_io_memory(0, sh_pci_mem.r, sh_pci_mem.w, p);
-     iop = cpu_register_io_memory(0, sh_pci_iop.r, sh_pci_iop.w, p);
--    cpu_register_physical_memory(p->regbase, 0x224, reg);
--    cpu_register_physical_memory(p->iopbase, 0x40000, iop);
--    cpu_register_physical_memory(p->membase, 0x1000000, mem);
-+    mem = cpu_register_io_memory(0, sh_pci_mem.r, sh_pci_mem.w, p);
-+    cpu_register_physical_memory(0x1e200000, 0x224, reg);
-+    cpu_register_physical_memory(0x1e240000, 0x40000, iop);
-+    cpu_register_physical_memory(0x1d000000, 0x1000000, mem);
-+    cpu_register_physical_memory(0xfe200000, 0x224, reg);
-+    cpu_register_physical_memory(0xfe240000, 0x40000, iop);
-+    cpu_register_physical_memory(0xfd000000, 0x1000000, mem);
- 
-     p->dev->config[0x00] = 0x54; // HITACHI
-     p->dev->config[0x01] = 0x10; //
--- 
-1.5.6.3
-
-
-/yoshii
-
-
