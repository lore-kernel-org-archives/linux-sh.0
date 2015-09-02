From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 02 Sep 2015 07:17:18 +0000
Subject: [PATCH v6 02/05] clk: shmobile: Add r8a7795 SoC to MSTP bindings
Message-Id: <20150902071718.10870.29881.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150902071657.10870.37652.sendpatchset@little-apple>
In-Reply-To: <20150902071657.10870.37652.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add r8a7795 to the MSTP DT binding documentation.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V5: (Magnus Damm <damm+renesas@opensource.se>)
 - Added Acked-by from Laurent

 Changes since V4: (Magnus Damm <damm+renesas@opensource.se>)
 - Added Acked-by from Geert

 Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
 - Picked up patch floating around on ML, added change log

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt |    1 +
 1 file changed, 1 insertion(+)

--- 0001/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ work/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt	2015-08-29 16:18:30.672366518 +0900
@@ -19,6 +19,7 @@ Required Properties:
     - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2-W) MSTP gate clocks
     - "renesas,r8a7793-mstp-clocks" for R8A7793 (R-Car M2-N) MSTP gate clocks
     - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
+    - "renesas,r8a7795-mstp-clocks" for R8A7795 (R-Car H3) MSTP gate clocks
     - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
     and "renesas,cpg-mstp-clocks" as a fallback.
   - reg: Base address and length of the I/O mapped registers used by the MSTP
