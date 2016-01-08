From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 08 Jan 2016 21:12:29 +0000
Subject: [RFC v4 0/4] watchdog: add driver for RWDT watchdog
Message-Id: <1452287553-18895-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

So, here is my newest version of the RWDT watchdog driver. Changes since last RFC:

* added binding docs
* removed 'timeout' module parameter in favor of dt setting 'timeout-sec'
  (The Gen3 BSP did this using an incremental patch)
* added comment about this driver and Gen2 HW issues
* rebased to renesas-drivers-2016-01-05-v4.4-rc8
* use min_t() instead of min()

I tested this on Lager with my hacky patches enabling RWDT in UP mode. For this
series, I picked and updated the integration patches for Gen3 from the BSP.
Note that this driver also needs a RESET module driver to work on Gen3. Since
we don't have that yet (couldn't even find it in the BSP), it is untested on
Gen3. Since it works on Gen2 and the datasheet doesn't specify any difference,
my proposal would be that I mark this task as done and leave the integration
with the reset module to the core group. If any problems with this driver show
up, I'll be there, of course. Would that be okay with the core group?

Regards,

   Wolfram

Takeshi Kihara (1):
  arm64: dts: salvator-x: Enable watchdog timer

Wolfram Sang (3):
  watchdog: renesas-rwdt: add driver
  arm64: dts: r8a7795: Add RWDT node
  clk: r8a7795: add RWDT clock

 .../devicetree/bindings/watchdog/renesas-rwdt.txt  |  18 ++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   4 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   7 +
 drivers/clk/shmobile/r8a7795-cpg-mssr.c            |   1 +
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/renesas_rwdt.c                    | 224 +++++++++++++++++++++
 7 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas-rwdt.txt
 create mode 100644 drivers/watchdog/renesas_rwdt.c

-- 
2.1.4

