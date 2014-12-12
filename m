From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Date: Fri, 12 Dec 2014 16:34:56 +0000
Subject: [PATCH v3 5/7] ARM: zynq: Enable pinctrl
Message-Id: <7af19dab6e804ce096e5af4654f6452c@BL2FFO11FD045.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1418402098-3811-1-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1418402098-3811-1-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Select pinctrl and the Zynq pinctrl driver.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
Changes since RFC v2:
 - separate mach-zynq changes in their own patch
---
 arch/arm/mach-zynq/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index aaa5162c1509..78e5e007f52d 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -9,6 +9,8 @@ config ARCH_ZYNQ
 	select HAVE_ARM_TWD if SMP
 	select ICST
 	select MFD_SYSCON
+	select PINCTRL
+	select PINCTRL_ZYNQ
 	select SOC_BUS
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
--=20
2.2.0.1.g9ee0458

