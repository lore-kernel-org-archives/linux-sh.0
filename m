From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2015 04:53:37 +0000
Subject: [PATCH 04/13] ARM: shmobile: mackerel: Remove DT binding documentation
Message-Id: <20150121045337.7648.33836.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
In-Reply-To: <20150121045256.7648.7451.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the DT compatibile string documentation for the
no longer supported Mackerel board.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Documentation/devicetree/bindings/arm/shmobile.txt |    2 --
 1 file changed, 2 deletions(-)

--- 0001/Documentation/devicetree/bindings/arm/shmobile.txt
+++ work/Documentation/devicetree/bindings/arm/shmobile.txt	2015-01-21 11:10:46.507575167 +0900
@@ -57,8 +57,6 @@ Boards:
     compatible = "renesas,kzm9g", "renesas,sh73a0"
   - Lager (RTP0RC7790SEB00010S)
     compatible = "renesas,lager", "renesas,r8a7790"
-  - Mackerel (R0P7372LC0016RL, AP4 EVM 2nd)
-    compatible = "renesas,mackerel"
   - Marzen
     compatible = "renesas,marzen", "renesas,r8a7779"
 
