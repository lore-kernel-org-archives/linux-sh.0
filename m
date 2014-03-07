From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Mar 2014 16:00:38 +0000
Subject: [PATCH V3 02/12] ARM: shmobile: r7s72100: document MSTP clock support
Message-Id: <1394208048-32495-3-git-send-email-wsa@the-dreams.de>
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
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index a6a352c2771e..395b2e8ecfd1 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -10,6 +10,7 @@ index in the group, from 0 to 31.
 Required Properties:
 
   - compatible: Must be one of the following
+    - "renesas,r7s72100-mstp-clocks" for R7S72100 (RZ) MSTP gate clocks
     - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
     - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
-- 
1.9.0

