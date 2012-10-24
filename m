From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Date: Wed, 24 Oct 2012 10:55:59 +0000
Subject: [PATCH 0/5] i2c-sh_mobile non-urgent changes
Message-Id: <5087C93F.6080601@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

This is the first batch to fix the i2c-sh_mobile driver.  As a first
step, this comprises of the SCL optimization work and a simple fix to
annoying spurious WAIT interrupt issue; in other words, this does not
change tx/rx data handling logic.

This driver has an architectural problem with send/receive procedures
and needs a fundamental overhaul.  I've been working on splitting into
logical chunks, but not yet completed.

Patches are prepared against the vanilla v3.6.  I don't have a chance
to give it a try with v3.6+ kernels myself, but tend to be optimistic
about that.  I have been cooking these patches over a year, and they
work perfectly fine with older kernels ..v3.4 so far.


Shinya Kuribayashi (5):
      i2c: i2c-sh_mobile: calculate clock parameters at driver probing time
      i2c: i2c-sh_mobile: optimize ICCH/ICCL values according to I2C bus speed
      i2c: i2c-sh_mobile: fix ICCH to avoid violation of the tHD;STA timing spec
      i2c: i2c-sh_mobile: support I2C hardware block with a faster operating clock
      i2c: i2c-sh_mobile: fix spurious transfer request timed out

 drivers/i2c/busses/i2c-sh_mobile.c | 150 ++++++++++++++++++++++++-------------
 include/linux/i2c/i2c-sh_mobile.h  |   1 +
 2 files changed, 98 insertions(+), 53 deletions(-)

--
Shinya Kuribayashi
Renesas Electronics
