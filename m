From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 26 Nov 2015 22:59:08 +0000
Subject: [RFC 0/9] i2c: add generic support for timing parameters
Message-Id: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Here is a patch series adding DT support for timing parameters like raise-time
or falling-time. There is a core function for parsing and an implementation for
the RCar driver how to use it.

This series is still RFC because some documentation is missing. It worked fine
on my Lager board this afternoon. However, since then my Lager board refuses to
boot new kernels, even known working branches with known working configs, so I
assume the current failure is unrelated. Anyway, this is to let you know what I
am up to. Please have a look and comment.

Cheers,

   Wolfram


Wolfram Sang (9):
  i2c: document generic DT bindings for timing parameters
  i2c: add generic routine to parse DT timing information
  i2c: rcar: refactor probe function a little
  i2c: rcar: switch to i2c generic dt parsing
  i2c: rcar: honor additional i2c timings from DT
  ARM: shmobile: r8a7790: dtsi: add internal delay for i2c IPs
  ARM: shmobile: r8a7791: dtsi: add internal delay for i2c IPs
  ARM: shmobile: r8a7794: dtsi: add internal delay for i2c IPs
  arm64: renesas: r8a7795: add internal delay for i2c IPs

 Documentation/devicetree/bindings/i2c/i2c-rcar.txt |  4 ++
 Documentation/devicetree/bindings/i2c/i2c.txt      | 31 ++++++++--
 arch/arm/boot/dts/r8a7790.dtsi                     |  4 ++
 arch/arm/boot/dts/r8a7791.dtsi                     |  6 ++
 arch/arm/boot/dts/r8a7794.dtsi                     |  6 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  7 +++
 drivers/i2c/busses/i2c-rcar.c                      | 67 +++++++++++-----------
 drivers/i2c/i2c-core.c                             | 34 +++++++++++
 include/linux/i2c.h                                | 15 +++++
 9 files changed, 135 insertions(+), 39 deletions(-)

-- 
2.1.4

