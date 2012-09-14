From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Fri, 14 Sep 2012 09:14:27 +0000
Subject: [PATCH 0/2] ARM; shmobile: kzm9g: enable sensors on the board
Message-Id: <1347614069-23345-1-git-send-email-koba@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello, simon-san

KZM-A9-GT board (kzm9g) has 2 sensor chip on the board.
 - magnetometer AK8975
 - three-axis digital accelerometer ADXL345
This patch registers device driver and assign I2C slave address and IRQ.

Tetsuyuki Kobayashi (2):
  ARM: shmobile: kzm9g: enable magnetometer ak8975.
  ARM: shmobile: kzm9g: enable three-axis digital accelerometer ADXL345

 arch/arm/configs/kzm9g_defconfig     |    4 ++++
 arch/arm/mach-shmobile/board-kzm9g.c |   10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
1.7.9.5

