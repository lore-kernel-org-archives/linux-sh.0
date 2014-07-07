From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 07 Jul 2014 07:54:45 +0000
Subject: [PATCH v2 20/30] ARM: shmobile: armadillo800eva-reference: Initialise TMU device using DT
Message-Id: <1404719695-1634-21-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Initialise TMU device using DT when booting armadillo800eva
using DT-reference. This device was previously enabled when
booting with legacy-C but not with DT-reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index f47ab76..c430197 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -205,6 +205,10 @@
 	};
 };
 
+&tmu0 {
+	status = "okay";
+};
+
 &pfc {
 	ether_pins: ether {
 		renesas,groups = "gether_mii", "gether_int";
-- 
2.0.0.rc2

