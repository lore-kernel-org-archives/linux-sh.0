From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 10 Nov 2014 18:49:34 +0000
Subject: [PATCH v2 1/6] clk: shmobile: Deprecate renesas,clock-indices
Message-Id: <1415645379-3366-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Commit 8e33f91a0b84ae19 ("clk: shmobile: clk-mstp: change to using
clock-indices") forgot to replace all occurrences of
"renesas,clock-indices" in the driver-specific binding documentation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Drop the reference to "renesas,clock-indices" completely,
  - Add Acked-by.
---
 .../devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt         | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index e566fb79af9e4d37..0a80fa70ca265c0f 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -27,11 +27,11 @@ Required Properties:
     must appear in the same order as the output clocks.
   - #clock-cells: Must be 1
   - clock-output-names: The name of the clocks as free-form strings
-  - renesas,clock-indices: Indices of the gate clocks into the group (0 to 31)
+  - clock-indices: Indices of the gate clocks into the group (0 to 31)
 
-The clocks, clock-output-names and renesas,clock-indices properties contain one
-entry per gate clock. The MSTP groups are sparsely populated. Unimplemented
-gate clocks must not be declared.
+The clocks, clock-output-names and clock-indices properties contain one entry
+per gate clock. The MSTP groups are sparsely populated. Unimplemented gate
+clocks must not be declared.
 
 
 Example
-- 
1.9.1

