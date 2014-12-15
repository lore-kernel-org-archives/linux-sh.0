From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 15 Dec 2014 20:20:13 +0000
Subject: [RFC 0/4] prototype: switch I2C IP cores at runtime
Message-Id: <1418674817-12809-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Some SoC (like Renesas RCar Gen2) have different I2C IP cores with different
feature sets. This is an experimental patch series to let those different IP
cores access the same I2C bus at runtime. Finally, we have some code to talk
about :) Unlike previous sketched versions, this one does not require a
remove/probe-cycle of I2C bus drivers which would mean complete
reinitialization of all connected I2C clients. However, the first two patches
need serious discussion. So, have a look if you are interested...

These patches are only sent to the sh-list for now. I'd like to have consensus
here before involving people from the outside.


Wolfram Sang (4):
  pinctrl: allow to unselect a state
  i2c: mux: add function to reparent a mux
  ARM: shmobile: r8a7790: lager: add i2c-demuxer to dts
  i2c: mux: demux-pinctrl: add driver

 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  |  65 ++++++++
 arch/arm/boot/dts/r8a7790-lager.dts                |  54 ++++--
 drivers/i2c/i2c-mux.c                              |   8 +
 drivers/i2c/muxes/Kconfig                          |   6 +
 drivers/i2c/muxes/Makefile                         |   2 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              | 183 +++++++++++++++++++++
 drivers/pinctrl/core.c                             |  34 ++--
 include/linux/i2c-mux.h                            |   2 +
 include/linux/pinctrl/consumer.h                   |   5 +
 9 files changed, 334 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
 create mode 100644 drivers/i2c/muxes/i2c-demux-pinctrl.c

-- 
2.1.3

