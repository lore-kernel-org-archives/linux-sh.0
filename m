From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 20 Jun 2015 00:49:25 +0000
Subject: [PATCH 0/2] Error message clean-ups for Renesas R-Car CAN driver
Message-Id: <1593397.kKIHxKLe5s@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's the set of 2 patches against Marc Kleine-Budde's 'linux-can.git'
repo plus 3 fix patches just posted; they are small error message cleanups for
the Renesas R-Car CAN driver.

[1/2] rcar_can: print request_irq() error code
[2/2] rcar_can: unify error messages

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
