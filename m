From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 19 Feb 2013 17:29:52 +0000
Subject: [PATCH 0/3] serial/shmobile: Add OF support to SCI
Message-Id: <1361298586-30357-1-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We add support to probe shmobile SCI devices using device tree.

Here we face the much discussed issue of device tree bindings and driver data
configs. I followed the idea of grouping SoCs into similar hardware blocks.

The naming is:
renesas,shmobile-sci-hwb-1	for sh7372, sh73a0, r8a7740 and
renesas,shmobile-sci-hwb-2	for r8a7779

I looked up the configuration of the prementioned SoCs and came to the
conclusion that
+       .flags          = ...
+       .scscr          = ...
+       .scbrr_algo_id  = ...

are all properties that are SoC dependent and that they currently completely
describe the SoC-related configuration. This is however based on estimation
as the struct plat_sci_port contains more fields that are not used currently
in any board code but might be needed in the future. I don't know that.

Further I'm unsure how to add the DMA descriptors to the bindings. I haven't
found a driver that uses DMA except the flctl, that uses "dmas" and "dma-names",
but I don't know if this is still the way to go.

The patchset is based on topic/all+next

Thanks,

 Bastian



Bastian Hecht (3):
  serial: sh-sci: Add Device Tree probing
  ARM: mach-shmobile: r8a7740: Add DT names to clock list
  ARM: mach-shmobile: r8a7740: Setup the serial devices using DT

 .../bindings/tty/serial/renesas,sh-sci-serial.txt  |   27 +++++
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   76 +++++++++++++
 arch/arm/mach-shmobile/clock-r8a7740.c             |    9 ++
 arch/arm/mach-shmobile/setup-r8a7740.c             |   15 ++-
 drivers/tty/serial/sh-sci.c                        |  117 +++++++++++++++++++-
 5 files changed, 236 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/renesas,sh-sci-serial.txt

-- 
1.7.9.5

