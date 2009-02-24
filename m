From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 Feb 2009 13:23:51 +0000
Subject: [PATCH] sh: fix P4 iounmap() pass-through
Message-Id: <20090224132351.11674.87661.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix iounmap() of pass-through P4 addresses. Without this patch
iounmap() on the sh7780 rtc area results in a warning message.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/mm/ioremap_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/mm/ioremap_32.c
+++ work/arch/sh/mm/ioremap_32.c	2009-02-24 20:58:38.000000000 +0900
@@ -119,7 +119,7 @@ void __iounmap(void __iomem *addr)
 	unsigned long seg = PXSEG(vaddr);
 	struct vm_struct *p;
 
-	if (seg < P3SEG || seg >= P3_ADDR_MAX || is_pci_memaddr(vaddr))
+	if (seg < P3SEG || vaddr >= P3_ADDR_MAX || is_pci_memaddr(vaddr))
 		return;
 
 #ifdef CONFIG_32BIT
