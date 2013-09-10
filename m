From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 10 Sep 2013 11:39:51 +0000
Subject: [PATCH 0/3] Lager i2c bus support
Message-Id: <1378813194-19493-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is the i2c part of the previously posted HDMI encoder RFC. The
following suggestions have been applied:

- keep platform device out of SoC setup
- use device ID to trigger H2-specific behavior in i2c driver
  instead of platform data
- minor adjustments for style
- subjects cleared up

(The pinmux patch has been adopted by Laurent and thus omitted here.)

CU
Uli


Nguyen Viet Dung (2):
  i2c: rcar: support R-Car H2 in i2c bus driver
  ARM: shmobile: r8a7790: add the I2C bus clock

Ulrich Hecht (1):
  ARM: shmobile: r8a7790: lager: i2c support

 arch/arm/mach-shmobile/board-lager.c   | 60 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c | 11 +++++++
 drivers/i2c/busses/i2c-rcar.c          | 35 ++++++++++++++++++--
 3 files changed, 104 insertions(+), 2 deletions(-)

-- 
1.8.1.4

