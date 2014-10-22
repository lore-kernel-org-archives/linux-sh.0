From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 22 Oct 2014 09:38:29 +0000
Subject: [PATCH 3/3] ARM: shmobile: armadillo800eva dts: Enable TMU0
Message-Id: <1413970709-26607-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1413970709-26607-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1413970709-26607-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

ch0 will be used for clock events and for periodic clock events,
ch1 will be used as clock source.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 2703428557fce9fa..98504e0b06c8e2ca 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -299,3 +299,7 @@
 
 	status = "okay";
 };
+
+&tmu0 {
+	status = "okay";
+};
-- 
1.9.1

