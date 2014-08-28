From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 28 Aug 2014 07:47:54 +0000
Subject: [PATCH v2] of: Add vendor prefix for Sitronix
Message-Id: <1409212074-2966-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The stock ticker for Sitronix is just a number.
"sitronix,st1232" is already in use for the Sitronix st1232 touchscreen
controller on Atmark Techno Armadillo 800 EVA.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2: Mention armadillo
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 34cc1bfcebfd..41799a69964b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -126,6 +126,7 @@ silabs	Silicon Laboratories
 simtek
 sii	Seiko Instruments, Inc.
 sirf	SiRF Technology, Inc.
+sitronix	Sitronix Technology Corporation
 smsc	Standard Microsystems Corporation
 snps 	Synopsys, Inc.
 solidrun	SolidRun
-- 
1.9.1

