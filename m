From: Bill Pemberton <wfp5p@virginia.edu>
Date: Wed, 21 Nov 2012 20:34:55 +0000
Subject: [PATCH 4/9] sh/PCI: Remove CONFIG_HOTPLUG ifdefs
Message-Id: <1353530100-728-5-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-sh.vger.kernel.org>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-sh@vger.kernel.org

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/drivers/pci/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index a7e078f..81e5daf 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -319,7 +319,5 @@ EXPORT_SYMBOL(pci_iounmap);
 
 #endif /* CONFIG_GENERIC_IOMAP */
 
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
-#endif
-- 
1.8.0

