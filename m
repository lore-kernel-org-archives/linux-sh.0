From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 21 May 2015 10:50:10 +0000
Subject: [RFC 0/3] Generic R-Car Gen2 SoC setup
Message-Id: <1432205413-9584-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This is an attempt to implement the consolidation of R-Car Gen2 SoC setup
code suggested by Laurent.  In order to preserve DT compatibility, it is
currently limited to r8a7793 (which is new) and r8a7794 (which doesn't have
SMP in upstream yet).

Even though it would not be possible to apply this to r8a7790 and r8a7791
without breaking DT compatibility, it still looks like a good idea to me to
include their respective DT_MACHINE_START bits in setup-rcar-gen2.c and
eliminate the setup files to keep everything in one place (and reduce
boilerplate).

This series depends on version 3 of the "r8a7793 SoC, Gose board support"
series.

CU
Uli


Ulrich Hecht (3):
  ARM: shmobile: rcar-gen2: Add generic "renesas,rcar-gen2" machine
  ARM: shmobile: r8a7793: use generic "renesas,rcar-gen2" machine
  ARM: shmobile: r8a7794: use generic "renesas,rcar-gen2" machine

 Documentation/devicetree/bindings/arm/shmobile.txt |  8 +++--
 arch/arm/boot/dts/r8a7793-gose.dts                 |  2 +-
 arch/arm/boot/dts/r8a7793.dtsi                     |  2 +-
 arch/arm/boot/dts/r8a7794-alt.dts                  |  2 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |  2 +-
 arch/arm/mach-shmobile/Makefile                    |  2 --
 arch/arm/mach-shmobile/setup-r8a7793.c             | 34 ----------------------
 arch/arm/mach-shmobile/setup-r8a7794.c             | 33 ---------------------
 arch/arm/mach-shmobile/setup-rcar-gen2.c           | 13 +++++++++
 9 files changed, 23 insertions(+), 75 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c

-- 
2.3.5

