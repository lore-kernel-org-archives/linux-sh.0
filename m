From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:35:40 +0000
Subject: [PATCH 09/09] sh: export board_pci_channels in one place
Message-Id: <20080219123540.4266.97987.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Instead of sometimes exporting board_pci_channels[] in the board specific
code just export it in one place.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/drivers/pci/ops-cayman.c     |    1 -
 arch/sh/drivers/pci/ops-lboxre2.c    |    2 --
 arch/sh/drivers/pci/ops-r7780rp.c    |    1 -
 arch/sh/drivers/pci/ops-rts7751r2d.c |    1 -
 arch/sh/drivers/pci/ops-sdk7780.c    |    1 -
 arch/sh/drivers/pci/ops-se7780.c     |    1 -
 arch/sh/drivers/pci/ops-titan.c      |    1 -
 arch/sh/drivers/pci/pci.c            |    2 ++
 8 files changed, 2 insertions(+), 8 deletions(-)

--- 0001/arch/sh/drivers/pci/ops-cayman.c
+++ work/arch/sh/drivers/pci/ops-cayman.c	2008-02-14 18:31:27.000000000 +0900
@@ -85,7 +85,6 @@ struct pci_channel board_pci_channels[] 
 	{ &sh5_pci_ops, NULL, NULL, 0, 0xff },
 	{ NULL, NULL, NULL, 0, 0 },
 };
-EXPORT_SYMBOL(board_pci_channels);
 
 int __init pcibios_init_platform(void)
 {
--- 0011/arch/sh/drivers/pci/ops-lboxre2.c
+++ work/arch/sh/drivers/pci/ops-lboxre2.c	2008-02-14 18:31:35.000000000 +0900
@@ -27,8 +27,6 @@ struct pci_channel board_pci_channels[] 
 	{ },
 };
 
-EXPORT_SYMBOL(board_pci_channels);
-
 static struct sh4_pci_address_map sh7751_pci_map = {
 	.window0	= {
 		.base	= SH7751_CS3_BASE_ADDR,
--- 0010/arch/sh/drivers/pci/ops-r7780rp.c
+++ work/arch/sh/drivers/pci/ops-r7780rp.c	2008-02-14 18:31:43.000000000 +0900
@@ -30,7 +30,6 @@ struct pci_channel board_pci_channels[] 
 	{ sh7780_pci_init, },
 	{ },
 };
-EXPORT_SYMBOL(board_pci_channels);
 
 static struct sh4_pci_address_map sh7780_pci_map = {
 	.window0	= {
--- 0011/arch/sh/drivers/pci/ops-rts7751r2d.c
+++ work/arch/sh/drivers/pci/ops-rts7751r2d.c	2008-02-14 18:31:49.000000000 +0900
@@ -34,7 +34,6 @@ struct pci_channel board_pci_channels[] 
 	{ sh7751_pci_init, },
 	{ },
 };
-EXPORT_SYMBOL(board_pci_channels);
 
 static struct sh4_pci_address_map sh7751_pci_map = {
 	.window0	= {
--- 0010/arch/sh/drivers/pci/ops-sdk7780.c
+++ work/arch/sh/drivers/pci/ops-sdk7780.c	2008-02-14 18:31:56.000000000 +0900
@@ -38,7 +38,6 @@ struct pci_channel board_pci_channels[] 
 	{ sh7780_pci_init, },
 	{ },
 };
-EXPORT_SYMBOL(board_pci_channels);
 
 static struct sh4_pci_address_map sdk7780_pci_map = {
 	.window0	= {
--- 0010/arch/sh/drivers/pci/ops-se7780.c
+++ work/arch/sh/drivers/pci/ops-se7780.c	2008-02-14 18:32:03.000000000 +0900
@@ -45,7 +45,6 @@ struct pci_channel board_pci_channels[] 
 	{ sh7780_pci_init, },
 	{ },
 };
-EXPORT_SYMBOL(board_pci_channels);
 
 static struct sh4_pci_address_map se7780_pci_map = {
 	.window0	= {
--- 0011/arch/sh/drivers/pci/ops-titan.c
+++ work/arch/sh/drivers/pci/ops-titan.c	2008-02-14 18:32:08.000000000 +0900
@@ -41,7 +41,6 @@ struct pci_channel board_pci_channels[] 
 	{ sh7751_pci_init, },
 	{ },
 };
-EXPORT_SYMBOL(board_pci_channels);
 
 static struct sh4_pci_address_map sh7751_pci_map = {
 	.window0	= {
--- 0006/arch/sh/drivers/pci/pci.c
+++ work/arch/sh/drivers/pci/pci.c	2008-02-14 18:31:21.000000000 +0900
@@ -237,3 +237,5 @@ void pci_iounmap(struct pci_dev *dev, vo
 	iounmap(addr);
 }
 EXPORT_SYMBOL(pci_iounmap);
+
+EXPORT_SYMBOL(board_pci_channels);
