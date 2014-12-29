From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:43:46 +0000
Subject: [PATCH 15/30] ARM: shmobile: lager: Fix QSPI mode of SPI-Flash into mode3
Message-Id: <cbf41168339adcb48de6a3537f88d4e85285db99.1419812186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

In order to change into mode3, CPOL and CPHA bit of SPCMD register
of QSPI is changed. Mode3 can avoid intermediate voltage.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[horms: Updated changelog and re-ordered properties]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 636d53b..bc257e8 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -397,6 +397,8 @@
 		spi-max-frequency = <30000000>;
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
+		spi-cpha;
+		spi-cpol;
 		m25p,fast-read;
 
 		partition@0 {
-- 
2.1.3

