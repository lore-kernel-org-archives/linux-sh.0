From: Tetsuyuki Kobayshi <koba@kmckk.co.jp>
Date: Mon, 23 Jul 2012 10:57:16 +0000
Subject: [PATCH v2] ARM: mach-shmobile: Add compilation support for dtbs using 'make dtbs'
Message-Id: <1343041036-13543-1-git-send-email-koba@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Add compilation support for dtbs using 'make dtbs'

Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
Sorry, I found mistake. it should be dtb insted of dts.

Changes for v2
- replace dts to dtb in the 3rd and 4th line of patch.

 arch/arm/mach-shmobile/Makefile.boot |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 498efd9..5e41019 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -7,3 +7,7 @@ __ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
 #
 #params_phys-y (Instead: Pass atags pointer in r2)
 #initrd_phys-y (Instead: Use compiled-in initramfs)
+
+dtb-$(CONFIG_MACH_KZM9G) += sh73a0-kzm9g.dtb
+dtb-$(CONFIG_MACH_KZM9D) += emev2-kzm9d.dtb
+dtb-$(CONFIG_MACH_ARMADILLO800EVA) += r8a7740-armadillo800eva.dtb
-- 
1.7.9.5

