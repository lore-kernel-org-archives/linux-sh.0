From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 31 Oct 2014 10:51:15 +0000
Subject: [RFC 0/3] i2c: sh_mobile: add DMA support
Message-Id: <1414752678-26078-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

Here is my RFC to support DMA with the i2c-sh_mobile core. DMA works nicely
with my tests so far and we save 1 interrupt per transferred byte, yay! DMA is
opt-in, so if setting it up fails, we will fall back to PIO. The threshold for
selecting DMA is still under test, but probably good enough already. The major
issue currently: This driver uses subsys_initcall() but at that time DMA is not
available, and there is no deferred probe for DMA. So, switching to
module_init() makes DMA work, but this may cause side-effects for older boards
which rely on I2C being available early (to control some PMIC, for example).
This needs some more investigation. Also, the driver (like all I2C DMA drivers
currently) assumes that i2c message buffers are DMA capable. This is not always
true and might need some assistance from the I2C core.

Other than that, please test, review, comment. The series is based on
renesas-devel-20141030-v3.18-rc2 with Laurent's series "[PATCH v4 0/5] R-Car
Gen2 DMA Controller driver" on top of it. A git tree can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c-shmobile-dma-experimental

Thanks,

    Wolfram


Wolfram Sang (3):
  i2c: sh_mobile: add DMA support
  ARM: shmobile: r8a7790: add DMA nodes for IIC
  ARM: shmobile: r8a7791: add DMA nodes for IIC

 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   5 +
 arch/arm/boot/dts/r8a7790.dtsi                     |   8 +
 arch/arm/boot/dts/r8a7791.dtsi                     |   6 +
 drivers/i2c/busses/i2c-sh_mobile.c                 | 203 +++++++++++++++++++--
 4 files changed, 203 insertions(+), 19 deletions(-)

-- 
2.0.0

