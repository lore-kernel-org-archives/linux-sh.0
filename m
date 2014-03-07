From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Mar 2014 16:00:43 +0000
Subject: [PATCH V3 07/12] ARM: shmobile: r7s72100: genmai: activate scif2 for console output
Message-Id: <1394208048-32495-8-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index 941e72ce7c82..82901a2cd947 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -48,3 +48,7 @@
 		pagesize = <64>;
 	};
 };
+
+&scif2 {
+	status = "okay";
+};
-- 
1.9.0

