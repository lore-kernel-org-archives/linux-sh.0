From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 05 Aug 2015 13:18:24 +0000
Subject: [RFT 0/2] i2c: add support for r8a7795 (RCar H3)
Message-Id: <1438780706-20945-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>

Here are the driver updates to support this new SoC. Since I don't have HW
access, this is a request for testing. The IP cores are backwards compatible to
Gen2. So, as long as the clocks are properly setup and the bus speed is OK,
the rest should work out of the box.

Question: Shall I prototype the dtsi additions for these modules? On the one
hand, this is quite some change for not being able to test. On the other hand,
other people might be so busy setting up the rest, so it may be useful after
all.


Wolfram Sang (2):
  i2c: rcar: add support for r8a7795 (R-Car H3)
  i2c: sh_mobile: add support for r8a7795 (R-Car H3)

 Documentation/devicetree/bindings/i2c/i2c-rcar.txt      | 1 +
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 1 +
 drivers/i2c/busses/i2c-rcar.c                           | 3 +++
 drivers/i2c/busses/i2c-sh_mobile.c                      | 1 +
 4 files changed, 6 insertions(+)

-- 
2.1.4

