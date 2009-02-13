From: Rob Landley <rob@landley.net>
Date: Fri, 13 Feb 2009 08:45:53 +0000
Subject: Re: [Qemu-devel] Status of SH4 support in repository
Message-Id: <200902130245.53417.rob@landley.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_BNTlJWN6nmDTx54"
List-Id: <linux-sh.vger.kernel.org>
References: <20090209172352.cae23097.kristoffer.ericson@gmail.com>
	<20090210182909.b0dcab10.kristoffer.ericson@gmail.com>
	<4992C455.8020707@juno.dti.ne.jp>
In-Reply-To: <4992C455.8020707@juno.dti.ne.jp>
To: qemu-devel@nongnu.org
Cc: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

--Boundary-00=_BNTlJWN6nmDTx54
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 11 February 2009 06:28:05 Shin-ichiro KAWASAKI wrote:
> Kristoffer Ericson wrote:
> > On Wed, 11 Feb 2009 01:53:45 +0900
> >
> > Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp> wrote:
> >> Hi, Kristoffer.
> >>
> >> Kristoffer Ericson wrote:
> >>> Greetings,
> >>>
> >>> Just interested in an update of the current status. I built a fresh
> >>> qemu from the repository today and Im currently I get no output.
> >>
> >> I do not catch 'no output' mean.  Could you explain it more?
> >>
> >> FYI, here's the log how I built qemu-sh at Feb. 6th.
> >>   http://www.assembla.com/wiki/show/qemu-sh4/BuildingEnvironment
> >
> > My mistake I did something wrong when I built it earlier, currently
> > it works somewhat. What doesnt work is keyboard,mouse and booting
> > from image file (seems like to bootstring isnt being aknowledged).
>
> Current qemu sh4 system emulation does not support either usb host
> or kernel boot command line.  You still need to apply some patches
> to use those features.
>
> Please check qemu-sh patch staging repository, which holds patches
> for qemu-sh. README in it explains how to apply.
>   http://git.kernel.org/?p=virt/qemu/lethal/qemu-sh.git;a=summary

My blocker is the lack of a working -append.  You have a git tree for a
collection of 5 patches, which then wants to invoke "quilt" to apply them. 
(Seems like overkill.)

At a guess, this seems like the patch that implements it is
staging/sh4-r2d-update-pci-usb-and-kernel-management.patch

> To apply all them, you need to role back qemu to rev 6215, for now.

No you don't, you just need a chainsaw and some duct tape...

> The patch for usb host is already posted to qemu-ml.  But I guess
> patch for kernel boot command line for r2d is not yet posted.

I adjusted the above patch to apply to current qemu svn, and attached the 
result, but it didn't make -append work.  It's still using the hardwired one.

Any suggestions?  (Do I need to look at the other patches?  This one looked 
like it was _trying_ to fix the problem...)

Rob

--Boundary-00=_BNTlJWN6nmDTx54
Content-Type: text/x-patch;
  charset="iso-2022-jp";
  name="r2d.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="r2d.patch"

Index: hw/r2d.c
===================================================================
--- hw/r2d.c	(revision 6618)
+++ hw/r2d.c	(working copy)
@@ -224,29 +224,41 @@
 	       serial_hds[2]);
 
     /* onboard CF (True IDE mode, Master only). */
-    mmio_ide_init(0x14001000, 0x1400080c, irq[CF_IDE], 1,
-        drives_table[drive_get_index(IF_IDE, 0, 0)].bdrv, NULL);
+    if ((i = drive_get_index(IF_IDE, 0, 0)) != -1)
+      mmio_ide_init(0x14001000, 0x1400080c, irq[CF_IDE], 1,
+          drives_table[drive_get_index(IF_IDE, 0, 0)].bdrv, NULL);
 
+    /* PCI host and peripherals */
+    pci = sh_pci_register_bus(r2d_pci_set_irq, r2d_pci_map_irq, irq, 0, 4);
+
     /* NIC: rtl8139 on-board, and 2 slots. */
-    pci_nic_init(pci, &nd_table[0], 2 << 3, "rtl8139");
+    if (nb_nics)
+        pci_nic_init(pci, &nd_table[0], 2 << 3, "rtl8139");
     for (i = 1; i < nb_nics; i++)
         pci_nic_init(pci, &nd_table[i], -1, "ne2k_pci");
 
+    if (usb_enabled)
+        usb_ohci_init_pci(pci, 4, -1);
+
     /* Todo: register on board registers */
-    {
+    if (kernel_filename) {
       int kernel_size;
       /* initialization which should be done by firmware */
       stl_phys(SH7750_BCR1, 1<<3); /* cs3 SDRAM */
       stw_phys(SH7750_BCR2, 3<<(3*2)); /* cs3 32bit */
 
-      kernel_size = load_image(kernel_filename, phys_ram_base);
-
+      if (kernel_cmdline) {
+          kernel_size = load_image(kernel_filename, phys_ram_base + 0x80000);
+          env->pc = (SDRAM_BASE + 0x80000) | 0xa0000000;
+          pstrcpy(phys_ram_base + 0x10100, 256, kernel_cmdline);
+      } else {
+          kernel_size = load_image(kernel_filename, phys_ram_base);
+          env->pc = SDRAM_BASE | 0xa0000000; /* Start from P2 area */
+      }
       if (kernel_size < 0) {
         fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filename);
         exit(1);
       }
-
-      env->pc = SDRAM_BASE | 0xa0000000; /* Start from P2 area */
     }
 }
 

--Boundary-00=_BNTlJWN6nmDTx54--
