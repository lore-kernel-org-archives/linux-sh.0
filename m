From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Aug 2014 03:35:01 +0000
Subject: [PATCH 02/05] ARM: shmobile: armadillo800eva: Build DTS for multiplatform
Message-Id: <20140828033501.18867.73429.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Build the r8a7740 Armadillo800EVA board DTB in case
of Multiplatform. The DT reference case will be removed
and can be ignored for now.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2014-08-27 18:38:49.000000000 +0900
@@ -372,6 +372,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += r7
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
+	r8a7740-armadillo800eva.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
 	r8a7790-lager.dtb \
