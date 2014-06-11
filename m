From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 11 Jun 2014 11:05:53 +0000
Subject: [PATCH v2 7/7] ARM: shmobile: koelsch: Enable PCIe Controller
Message-Id: <1402484753-7471-8-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index b2e6616..5acb01f 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -430,6 +430,10 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu0-supply = <&vdd_dvfs>;
 };
-- 
2.0.0

