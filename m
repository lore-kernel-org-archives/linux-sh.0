From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 07 Apr 2014 20:07:07 +0000
Subject: [PATCH 7/9] ARM: shmobile: lager: enable sysdma units 0 and 1
Message-Id: <1396901229-29117-8-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>

Add the new sysdma units to the lager board.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 26a9010..3b4f59c 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -214,3 +214,11 @@
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&sysdma0 {
+	status = "okay";
+};
+
+&sysdma1 {
+	status = "okay";
+};
-- 
1.9.1

