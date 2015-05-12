From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:04 +0000
Subject: [PATCH/RFC 01/12] ARM: shmobile: armadillo dts: Add aliases for all serial ports
Message-Id: <1431452235-11692-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add aliases for the remaining serial ports that don't already have an
alias.

This is a temporary workaround, until of_alias_add() is called when
loading a device tree overlay that adds an alias.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 2e31d8c01cbf6a74..e51ad203be73dcdb 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -20,7 +20,15 @@
 	compatible = "renesas,armadillo800eva", "renesas,r8a7740";
 
 	aliases {
+		serial0 = &scifa0;
 		serial1 = &scifa1;
+		serial2 = &scifa2;
+		serial3 = &scifa3;
+		serial4 = &scifa4;
+		serial5 = &scifa5;
+		serial6 = &scifa6;
+		serial7 = &scifa7;
+		serial8 = &scifb;
 	};
 
 	chosen {
-- 
1.9.1

