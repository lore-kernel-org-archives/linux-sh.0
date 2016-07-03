From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 16:46:37 +0000
Subject: [PATCH v5 17/22] pci: PCI_HOST_GENERIC enable for SH
Message-Id: <1467564402-2649-18-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Changes v4
none

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index df60505..83184eb 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -83,7 +83,7 @@ config PCI_HOST_COMMON
 
 config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
-	depends on (ARM || ARM64) && OF
+	depends on (ARM || ARM64 || SUPERH) && OF
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want to support a simple generic PCI host
-- 
2.7.0

