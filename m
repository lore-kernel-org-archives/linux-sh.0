From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 13 Mar 2014 09:50:08 +0000
Subject: [PATCH 9/9] ARM: koelsch: Add HAVE_ARM_ARCH_TIMER to defconfig
Message-Id: <1394704208-7490-10-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394704208-7490-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1394704208-7490-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Phil Edworthy <phil.edworthy@renesas.com>

This is fixes a boot problem when the R-Car PCIe driver is enabled.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/configs/koelsch_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index ec14547..67666b6 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -15,6 +15,7 @@ CONFIG_MACH_KOELSCH=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_RCAR_GEN2_PCIE=y
-- 
1.7.9.5

