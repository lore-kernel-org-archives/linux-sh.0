From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Fri, 30 Jun 2017 00:54:02 +0000
Subject: [PATCH 0/6] i2c: pca-platform: additional improvements
Message-Id: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org
Cc: ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

This series addresses some of the points identified by Andy. The series is
based on top of i2c/for-next.

I haven't got a working sh4 toolchain so I haven't been able to compile test
patch 1/1.

Chris Packham (6):
  sh: sh7785lcr: add GPIO lookup table for i2c controller reset
  i2c: pca-platform: correctly set algo_data.reset_chip
  i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
  i2c: pca-platform: unconditionally use devm_gpiod_get_optional
  i2c: pca-platform: use device_property_read_u32
  i2c: pca-platform: drop gpio from platform data

 arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
 arch/sh/boards/board-sh7785lcr.c          | 11 +++++++-
 drivers/i2c/busses/i2c-pca-platform.c     | 42 +++++++++++--------------------
 include/linux/i2c-pca-platform.h          |  3 ---
 4 files changed, 25 insertions(+), 32 deletions(-)

-- 
2.13.0

