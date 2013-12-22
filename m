From: takasi-y@ops.dti.ne.jp
Date: Sun, 22 Dec 2013 09:27:23 +0000
Subject: [PATCH 1/2] ARM: shmobile: koelsch: (1+1)GiB memory in DT
Message-Id: <1387704444-750-2-git-send-email-takasi-y@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Fix dts to have memory 1GiB @ 0_4000_0000 + 1GiB @ 2_0000_0000
according to Koelsch's hardware manual.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index fd556c3..63eee03 100644
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
1.7.9.5

