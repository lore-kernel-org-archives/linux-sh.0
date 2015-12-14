From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 14 Dec 2015 15:42:35 +0000
Subject: [PATCH 3/6] arm64: dts: salvator-x: Enable SATA controller
Message-Id: <1450107758-2544-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kouei Abe <kouei.abe.cp@renesas.com>

This enables SATA device in r8a7795-salvator-x.dts.

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 0c67442..297c9f0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -268,6 +268,10 @@
 	};
 };
 
+&sata {
+	status = "okay";
+};
+
 &ssi1 {
 	shared-pin;
 };
-- 
2.6.3

