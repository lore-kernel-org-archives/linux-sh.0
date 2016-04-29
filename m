From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Apr 2016 12:58:25 +0000
Subject: [PATCH v2 02/11] serial: sh-sci: Update DT binding documentation for dedicated RTS/CTS
Message-Id: <1461934714-18681-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1461934714-18681-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1461934714-18681-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org

Some Renesas SCIF UARTs have dedicated lines for RTS/CTS hardware flow
control.  Whether these lines exist depends on SoC and UART instance
inside the SoC.  Whether these lines can be used for hardware flow
control depends on board wiring.

Amend the DT bindings with an optional property to indicate that RTS/CTS
hardware flow control lines exist, and can be used as such, according to
the Generic Serial DT Bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
v2:
  - Drop RFC status,
  - Use "uart-has-rtscts" instead of "renesas,uart-has-rtscts",
  - Refer to the Generic Serial DT Bindings.
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 997baeaa869baa6f..7a0e15053db97481 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -78,6 +78,8 @@ Optional properties:
   - dma-names: Must contain a list of two DMA names, "tx" and "rx".
   - {cts,dsr,dcd,rng,rts,dtr}-gpios: Specify GPIOs for modem lines, cfr. the
     generic serial DT bindings in serial.txt.
+  - uart-has-rtscts: Indicates dedicated lines for RTS/CTS hardware flow
+    control, cfr. the generic serial DT bindings in serial.txt.
 
 Example:
 	aliases {
-- 
1.9.1

