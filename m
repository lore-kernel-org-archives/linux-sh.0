From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 07 Apr 2014 19:16:52 +0000
Subject: [PATCH] ARM: shmobile: lager: correct renesas,gpios to renesas,groups in sd[02] pfc
Message-Id: <1396898212-7078-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, Rob Taylor <rob.taylor@codethink.co.uk>, Ben Dooks <ben.dooks@codethink.co.uk>

From: Rob Taylor <rob.taylor@codethink.co.uk>

Fix probable typo of renesas,groups in the lager dt. The kernel has no
renesas,gpios but this should match renesas,groups.

Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
[ben.dooks@codethink.co.uk: fixup description]
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 6e99eb2..d01048a 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -141,12 +141,12 @@
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,gpios = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
 		renesas,function = "sdhi0";
 	};
 
 	sdhi2_pins: sd2 {
-		renesas,gpios = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
 
-- 
1.9.1

