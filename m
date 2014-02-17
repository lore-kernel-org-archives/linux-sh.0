From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Feb 2014 21:19:16 +0000
Subject: [PATCH 0/3] add i2c support to genmai
Message-Id: <1392671959-22834-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since I got renesas-devel-v3.14-rc3-20140217 to boot with r7s72100 again [1], I
could now verify that this series in deed makes I2C2 work with the genmai
board. The missing PFC patch can be added later once we have PFC support.
Because I2C is the default pinmux setup, it already works without PFC. Please
apply.

[1] http://thread.gmane.org/gmane.linux.kernel/1649638

Wolfram Sang (3):
  arm: shmobile: r7s72100: add nodes for i2c controllers to dtsi
  arm: shmobile: genmai: adapt dts to use native i2c driver
  ARM: shmobile: r7s72100: update defconfig for I2C usage

 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 11 ++++
 arch/arm/boot/dts/r7s72100.dtsi                 | 72 +++++++++++++++++++++++++
 arch/arm/configs/genmai_defconfig               |  4 +-
 3 files changed, 86 insertions(+), 1 deletion(-)

-- 
1.8.5.1

