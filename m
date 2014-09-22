From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 22 Sep 2014 09:51:10 +0000
Subject: [RFC PATCH 3/3] ARM: Enable PCI domains
Message-Id: <1411379470-20639-4-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1411379470-20639-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Since there are ARM devices with multiple independant PCI controllers, enable
PCI domains for all ARM devices.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
Marked as RFC as I am not sure of the impact of enabling PCI domains for all
ARM devices. In the march to 'one kernel to rule them all', I steered clear of
mach specific changes.

 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 32cbbd5..8741d3d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1274,6 +1274,7 @@ config ISA_DMA_API
 
 config PCI
 	bool "PCI support" if MIGHT_HAVE_PCI
+	select PCI_DOMAINS
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -1282,7 +1283,6 @@ config PCI
 
 config PCI_DOMAINS
 	bool
-	depends on PCI
 
 config PCI_NANOENGINE
 	bool "BSE nanoEngine PCI support"
-- 
2.1.0

