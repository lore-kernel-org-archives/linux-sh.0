From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:20:38 +0000
Subject: [PATCH 03/17] ARM: shmobile: koelsch: (1+1)GiB memory in DT
Message-Id: <4cd1bad45182c7f1426353d73a481e0260d236b1.1391665761.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Fix dts to have memory 1GiB @ 0_4000_0000 + 1GiB @ 2_0000_0000
according to Koelsch's hardware manual.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index c6f5de3..d30527d 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -23,7 +23,12 @@
 
 	memory@40000000 {
 		device_type = "memory";
-		reg = <0 0x40000000 0 0x80000000>;
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	memory@200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x40000000>;
 	};
 
 	lbsc {
-- 
1.8.5.2

