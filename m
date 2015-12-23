From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 23 Dec 2015 16:56:32 +0000
Subject: [PATCH 1/3] i2c: document binding for multi-master case
Message-Id: <1450889794-9509-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1450889794-9509-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1450889794-9509-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We need this binding because some I2C master drivers will need to adapt
their PM settings for the arbitration circuitry.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/i2c/i2c.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index a00219f5ee0733..c8d977ed847f3c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -54,6 +54,11 @@ wants to support one of the below features, it should adapt the bindings below.
 	"irq" and "wakeup" names are recognized by I2C core, other names are
 	left to individual drivers.
 
+- multi-master
+	states that there is another master active on this bus. The OS can use
+	this information to adapt power management to keep the arbitration awake
+	all the time, for example.
+
 - wakeup-source
 	device can be used as a wakeup source.
 
-- 
2.1.4

