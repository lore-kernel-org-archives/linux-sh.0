From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 05 Sep 2014 10:23:47 +0000
Subject: [PATCH v5 0/2] Initial r8a7794/Alt device tree
Message-Id: <1409912629-20835-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

These are the DT parts of the initial r8a7794 support, with the bugs pointed
out by Khiem Nguyen fixed and the unused MSTP5 bit 2 dropped.

CU
Uli

Changes since v4:
- dropped unused MSTP5 bit 2

Changes since v3:
- dropped C code
- fixed compatible property for GIC
- removed non-existing MSTP5 bit 1 in header file

Changes since v2:
- dropped bindings stuff
- split SoC and board DT into two patches

Changes since v1:
- removed loadaddr
- added init_late method to DT_MACHINE_START
- removed board file
- renamed serial10 to serial0 because we're not popular enough to be
  different
- reordered patches according to dependencies


Ulrich Hecht (2):
  ARM: shmobile: Initial r8a7794 SoC device tree
  ARM: shmobile: Initial Alt board device tree

 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/r8a7794-alt.dts         |  47 +++
 arch/arm/boot/dts/r8a7794.dtsi            | 531 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7794-clock.h |  80 +++++
 4 files changed, 660 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/r8a7794-alt.dts
 create mode 100644 arch/arm/boot/dts/r8a7794.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7794-clock.h

-- 
1.8.4.5

