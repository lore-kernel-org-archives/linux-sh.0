From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Dec 2013 02:38:33 +0000
Subject: [PATCH 05/05 v2] pinctrl: sh-pfc: r8a7791 and r7s72100 binding docs
Message-Id: <20131217023833.24573.83149.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131217023745.24573.3660.sendpatchset@w520>
In-Reply-To: <20131217023745.24573.3660.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linus.walleij@linaro.org, wsa@the-dreams.de, horms@verge.net.au, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Add compatible strings for r7s72100 and r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ work/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt	2013-12-16 19:55:12.000000000 +0900
@@ -10,11 +10,13 @@ Pin Control
 Required Properties:
 
   - compatible: should be one of the following.
+    - "renesas,pfc-r7s72100": for R7S72100 (RZ/A1H) compatible pin-controller.
     - "renesas,pfc-r8a73a4": for R8A73A4 (R-Mobile APE6) compatible pin-controller.
     - "renesas,pfc-r8a7740": for R8A7740 (R-Mobile A1) compatible pin-controller.
     - "renesas,pfc-r8a7778": for R8A7778 (R-Mobile M1) compatible pin-controller.
     - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
     - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible pin-controller.
+    - "renesas,pfc-r8a7791": for R8A7791 (R-Car M2) compatible pin-controller.
     - "renesas,pfc-sh7372": for SH7372 (SH-Mobile AP4) compatible pin-controller.
     - "renesas,pfc-sh73a0": for SH73A0 (SH-Mobile AG5) compatible pin-controller.
 
