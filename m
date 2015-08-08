From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:17 +0000
Subject: [PATCH 00/10] i2c: improve i2c client address spaces and their DT support
Message-Id: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>

Here is the updated RFC series ready for submission. This gives the i2c core
seperate address spaces for standard clients, 10 bit clients, and our own slave
clients. So, you can now have a 7 bit slave at 0x50 and a 10 bit slave at
0x050. Or, you can have a slave driver listening at some address and at the
same time have a client driver talking to this address. Note that this is only
the core support for that separation, I am still not sure if there is hardware
being able talking to its own slave address, but we will see. The RFC had DT
support, this series also has support for that when instantiating via sysfs at
runtime.

Changes since RFC:

* dropped the patches for Tegra slave support. I couldn't get them to work
  and we found out that they need further changes. Tests have now been
  performed with a Renesas Lager board
* the hardcoded arbitrary offsets have now been #defined. Other than that,
  patches 1-7 which also have been in the RFC stayed the same.
* patch 8 adds support for the new flags in sysfs
* patch 9 gives some extra warning for users in case of a misconfiguration
* patch 10 finally introduces a binding documentation for generic i2c
  bindings. Finally, at last, hooray!
* tags from Andrey and Stephen have been added, thanks a lot!

Please comment, review...

Thanks,

   Wolfram


Wolfram Sang (10):
  dt-bindings: add header for generic I2C flags in bindings
  i2c: add a flag to mark clients as slaves
  i2c: apply address offset for slaves, too
  i2c: rename address check functions
  i2c: make address check indpendent from client struct
  i2c: apply DT flags when probing
  i2c: take address space into account when checking for used addresses
  i2c: support 10 bit and slave addresses in sysfs 'new_device'
  i2c: slave: print warning if slave flag not set
  i2c: dt: describe generic bindings

 Documentation/devicetree/bindings/i2c/i2c.txt | 33 ++++++++++
 Documentation/i2c/slave-interface             |  9 ++-
 Documentation/i2c/ten-bit-addresses           |  4 ++
 drivers/i2c/i2c-core.c                        | 88 ++++++++++++++++++++-------
 include/dt-bindings/i2c/i2c.h                 | 18 ++++++
 include/linux/i2c.h                           |  9 +--
 6 files changed, 131 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c.txt
 create mode 100644 include/dt-bindings/i2c/i2c.h

-- 
2.1.4

