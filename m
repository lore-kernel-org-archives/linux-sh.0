From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 02 Dec 2015 05:58:33 +0000
Subject: [PATCH v2 net-next 2/2] ravb: add device tree support for r8a779[123]
Message-Id: <1449035913-9129-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449035913-9129-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449035913-9129-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, devicetree@vger.kernel.org

Simply document new compatibility strings.
As a previous patch adds a generic R-Car Gen2 compatibility string
there appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* No change
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index 7555116b5db2..81a9f9e6b45f 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -5,6 +5,9 @@ interface contains.
 
 Required properties:
 - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
+	      "renesas,etheravb-r8a7791" if the device is a part of R8A7791 SoC.
+	      "renesas,etheravb-r8a7792" if the device is a part of R8A7792 SoC.
+	      "renesas,etheravb-r8a7793" if the device is a part of R8A7793 SoC.
 	      "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
 	      "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
 	      "renesas,etheravb-rcar-gen2" for generic R-Car Gen 2 compatible interface.
-- 
2.1.4

