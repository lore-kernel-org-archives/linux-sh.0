Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C217588
	for <linux-sh@vger.kernel.org>; Mon, 15 Jan 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:1376:70aa:e074:32d3])
	by albert.telenet-ops.be with bizsmtp
	id b1li2B00734Hgv9061liDQ; Mon, 15 Jan 2024 14:45:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rPNGr-00FdxB-N1;
	Mon, 15 Jan 2024 14:45:42 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rPNHa-00C0Vf-Dk;
	Mon, 15 Jan 2024 14:45:42 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: timer: renesas,tmu: Document input capture interrupt
Date: Mon, 15 Jan 2024 14:45:39 +0100
Message-Id: <fb1e38c93e62221f94304edd980a2fb79c1f2995.1705325608.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Timer Unit (TMU) instances with 3 channels support a fourth
interrupt: an input capture interrupt for the third channel.

While at it, document the meaning of the four interrupts, and add
"interrupt-names" for clarity.

Update the example to match reality.

Inspired by a patch by Yoshinori Sato for SH.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The corresponding DTS updates can be found in series "[PATCH 0/2]
ARM/arm64: dts: renesas: Improve TMU interrupt descriptions".
https://lore.kernel.org/r/cover.1705325654.git.geert+renesas@glider.be

 .../devicetree/bindings/timer/renesas,tmu.yaml | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
index a67e427a9e7e22aa..9a823224c144f7d4 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -46,7 +46,19 @@ properties:
 
   interrupts:
     minItems: 2
-    maxItems: 3
+    items:
+      - description: Underflow interrupt 0
+      - description: Underflow interrupt 1
+      - description: Underflow interrupt 2
+      - description: Input capture interrupt 2
+
+  interrupt-names:
+    minItems: 2
+    items:
+      - const: tuni0
+      - const: tuni1
+      - const: tuni2
+      - const: ticpi2
 
   clocks:
     maxItems: 1
@@ -100,7 +112,9 @@ examples:
             reg = <0xffd80000 0x30>;
             interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "tuni0", "tuni1", "tuni2", "ticpi2";
             clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
             clock-names = "fck";
             power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
-- 
2.34.1

