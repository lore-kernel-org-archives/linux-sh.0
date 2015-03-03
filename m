From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Tue, 03 Mar 2015 01:21:29 +0000
Subject: [PATCH 4/5] ARM: shmobile: alt dts: Add arm,cpu-registers-not-fw-configured
Message-Id: <54F50C99.9040003@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In case of using arch timer on r8a7794, Cortex-A7 core does not boot
since the virtual offset (CNTVOFF) of arch timer is not initialized.

This patch modifies to use physical arch timer on r8a7794(alt).

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7794-alt.dts |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 928cfa6..0764d60 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -59,3 +59,7 @@
 &scif2 {
 	status = "okay";
 };
+
+&timer {
+	arm,cpu-registers-not-fw-configured;
+};
-- 
1.7.9.5

