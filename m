From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 06 Aug 2014 04:39:27 +0000
Subject: [PATCH 0/5] i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
Message-Id: <87silaw7t2.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon <horms@verge.net.au>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-I2C <linux-i2c@vger.kernel.org>


Hi Wolfram, Simon

These patches add R-Car generatoin level
DT compatible on i2c-rcar driver and platform.

Kuninori Morimoto (5):
  i2c: rcar: add renesas,i2c-rcar-gen1/gen2 in DT compatible
  ARM: shmobile: r8a7778: add generation level compatible for i2c
  ARM: shmobile: r8a7779: add generation level compatible for i2c
  ARM: shmobile: r8a7790: add generation level compatible for i2c
  ARM: shmobile: r8a7791: add generation level compatible for i2c

 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |    4 +++-
 arch/arm/boot/dts/r8a7778.dtsi                     |    8 ++++----
 arch/arm/boot/dts/r8a7779.dtsi                     |    8 ++++----
 arch/arm/boot/dts/r8a7790.dtsi                     |    8 ++++----
 arch/arm/boot/dts/r8a7791.dtsi                     |   12 ++++++------
 drivers/i2c/busses/i2c-rcar.c                      |    2 ++
 6 files changed, 23 insertions(+), 19 deletions(-)

-- 
1.7.9.5

