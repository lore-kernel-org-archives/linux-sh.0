From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 30 Aug 2011 16:19:13 +0000
Subject: [PATCH] ARM: mach-shmobile: ag5evm needs CONFIG_I2C
Message-Id: <Pine.LNX.4.64.1108301815210.19151@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ag5evm implements a backlight control, using an I2C controller, therefore
it needs CONFIG_I2C to fix this make failure

arch/arm/mach-shmobile/built-in.o: In function `lcd_on':
pfc-sh73a0.c:(.text+0x2334): undefined reference to `i2c_get_adapter'
pfc-sh73a0.c:(.text+0x2370): undefined reference to `i2c_transfer'

(ignore pfc-sh73a0.c) and to build successfully.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0c8f6cf..f68856c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -26,6 +26,7 @@ config ARCH_SH73A0
 	select SH_CLK_CPG
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
+	select I2C
 
 comment "SH-Mobile Board Type"
 
-- 
1.7.2.5

