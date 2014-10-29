From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:19:08 +0000
Subject: [PATCH 1/6] clk: shmobile: Deprecate renesas,clock-indices
Message-Id: <1414592353-24044-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592353-24044-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414592353-24044-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Commit 8e33f91a0b84ae19 ("clk: shmobile: clk-mstp: change to using
clock-indices") forgot to mark "renesas,clock-indices" deprecated in
the driver-specific binding documentation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt        | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index a5f52238c80d5f9b..26ab9fc499f51113 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -26,11 +26,12 @@ Required Properties:
     must appear in the same order as the output clocks.
   - #clock-cells: Must be 1
   - clock-output-names: The name of the clocks as free-form strings
-  - renesas,clock-indices: Indices of the gate clocks into the group (0 to 31)
+  - clock-indices: Indices of the gate clocks into the group (0 to 31)
+    ("renesas,clock-indices" is deprecated)
 
-The clocks, clock-output-names and renesas,clock-indices properties contain one
-entry per gate clock. The MSTP groups are sparsely populated. Unimplemented
-gate clocks must not be declared.
+The clocks, clock-output-names and clock-indices properties contain one entry
+per gate clock. The MSTP groups are sparsely populated. Unimplemented gate
+clocks must not be declared.
 
 
 Example
-- 
1.9.1

