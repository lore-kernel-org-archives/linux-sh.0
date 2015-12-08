From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 08 Dec 2015 09:37:44 +0000
Subject: [PATCH v2 0/9] i2c: add generic support for timing parameters in DT
Message-Id: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Here is a patch series adding better DT support for timing parameters like the
raise time or the fall time which are generic for the I2C subsystem. There is a
core function for parsing and an implementation for the RCar driver how to use
it.

I added people of the designware and rk3x driver to CC because they might be
interested in this new function. They provided the basis for this series, so it
should be easy to convert them.

Please have a look, test, comment...

Thanks,

    Wolfram

Changes since V1:
* switched from DT properties to device properties
* that means no dependency on OF and rename of the parsing function
* removed a superfluous comment
* adapted the RCar driver to the changes
* added Rob's ack

Changes since RFC:
* better tested
* added documentation for the new function and the new struct
* reworded some commit messages slightly
* moved the new property in the dtsi above the "status" property

Wolfram Sang (9):
  i2c: document generic DT bindings for timing parameters
  i2c: add generic routine to parse DT for timing information
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
 drivers/i2c/i2c-core.c                             | 47 +++++++++++++++
 include/linux/i2c.h                                | 18 ++++++
 9 files changed, 151 insertions(+), 39 deletions(-)

-- 
2.1.4

