From: Tetsuyuki Kobayshi <koba@kmckk.co.jp>
Date: Wed, 05 Sep 2012 08:11:48 +0000
Subject: [PATCH 1/3] ARM: shmobile: sh73a0: Select ERRATAs in Kconfig
Message-Id: <1346832708-7369-1-git-send-email-koba@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

SH73a0 SoC has Cortex-A9 core which revision is r2p8.
This patch selects ERRATAs for this revision in Kconfig file.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/mach-shmobile/Kconfig |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4cacc2d..a80836c 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -28,6 +28,13 @@ config ARCH_SH73A0
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select I2C
+	select ARM_ERRATA_743622
+	select ARM_ERRATA_751472
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369
+	select PL310_ERRATA_588369 if CACHE_PL310
+	select PL310_ERRATA_727915 if CACHE_PL310
+	select PL310_ERRATA_769419 if CACHE_PL310
 
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
-- 
1.7.9.5

