From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 31 Mar 2014 10:30:55 +0000
Subject: [PATCH v7 10/10] ARM: shmobile: koelsch: Add PCIe to defconfig
Message-Id: <1396261856-22465-11-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

v6:
 - Add shmobile to subject
---
 arch/arm/configs/koelsch_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 86faab5..ec14547 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -15,6 +15,9 @@ CONFIG_MACH_KOELSCH=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_RCAR_GEN2_PCIE=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_NR_CPUS=8
-- 
1.9.0

