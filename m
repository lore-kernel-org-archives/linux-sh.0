From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 26 Feb 2014 18:11:22 +0000
Subject: [PATCH 4/5 v2 RFC] ARM: shmobile: Add PCIe to r8a7791 device Kconfig
Message-Id: <1393438283-10542-5-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393438283-10542-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1393438283-10542-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Phil Edworthy <phil.edworthy@renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a4a4b75..c623633 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -100,6 +100,8 @@ config ARCH_R8A7791
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
+	select MIGHT_HAVE_PCI
+	select PCI_QUIRKS if PCI
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
-- 
1.7.9.5

