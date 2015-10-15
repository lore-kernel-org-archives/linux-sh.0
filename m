From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 06:59:31 +0000
Subject: [PATCH/RFC 0/6] boot-mode-reg: Add core
Message-Id: <1444892377-10170-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The motivation for this new module is to add a small frame work to allow
kernel subsystems to obtain boot mode information from a centralised
source using a new, and hopefully soon well-known, API.

The new API consists of two function calls and nothing more:

boot_mode_reg_set: Should be called by platform-specific drivers
                   to register the boot mode register value which
                   they obtain from hardware or otherwise.

boot_mode_reg_get: Should be called by consumers; subsystems that
                   wish to know he boot mode register.

The boot mode register is a 32bit unsigned entity,
the meaning of its values are implementation dependent.


This patchset:
* Adds the API described above
* Implements the API for Renesas R-Car Gen2 SoCs
* Uses the implementation for Renesas R-Car Gen2 SoCs

Laurent, this is my interpretation of your ideas in this area.
In particular I'd value feedback from you on the implementation
before taking it to a wider audience.


Tested on an r8a7791/Koelsch applied on top of
renesas-devel-20151015-v4.3-rc5

Simon Horman (6):
  boot-mode-reg: Add core
  boot-mode-reg: Add R-Car Gen2 driver
  arm: shmobile: rcar-gen2: Obtain MD pin value using boot-mode-reg
  arm: shmobile: r8a7791: Obtain MD pin value using boot-mode-reg
  clk: shmobile: rcar-gen2: Obtain MD pin value using boot-mode-reg
  arm: shmobile: rcar-gen2: Remove unused rcar_gen2_read_mode_pins()

 MAINTAINERS                              |  1 +
 arch/arm/mach-shmobile/Kconfig           |  1 +
 arch/arm/mach-shmobile/rcar-gen2.h       |  1 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 43 +++++++++---------
 arch/arm/mach-shmobile/smp-r8a7791.c     | 13 +++++-
 drivers/clk/shmobile/clk-rcar-gen2.c     | 12 ++++-
 drivers/misc/Kconfig                     |  1 +
 drivers/misc/Makefile                    |  1 +
 drivers/misc/boot-mode-reg/Kconfig       | 19 ++++++++
 drivers/misc/boot-mode-reg/Makefile      |  7 +++
 drivers/misc/boot-mode-reg/core.c        | 78 ++++++++++++++++++++++++++++++++
 drivers/misc/boot-mode-reg/rcar-gen2.c   | 61 +++++++++++++++++++++++++
 include/linux/clk/shmobile.h             |  2 +-
 include/misc/boot-mode-reg.h             | 27 +++++++++++
 14 files changed, 240 insertions(+), 27 deletions(-)
 create mode 100644 drivers/misc/boot-mode-reg/Kconfig
 create mode 100644 drivers/misc/boot-mode-reg/Makefile
 create mode 100644 drivers/misc/boot-mode-reg/core.c
 create mode 100644 drivers/misc/boot-mode-reg/rcar-gen2.c
 create mode 100644 include/misc/boot-mode-reg.h

-- 
2.1.4

