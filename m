From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 07 Aug 2015 16:34:55 +0000
Subject: [PATCH 0/2] kill bockw reference platform
Message-Id: <1438965297-12888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

As discussed off-list, here's the burial of the r8a7778 bockw reference
platform, the penultimate step in removing legacy platforms for good.

CU
Uli


Ulrich Hecht (2):
  ARM: shmobile: bockw: remove "reference" device tree
  ARM: shmobile: bockw: remove "reference" board file and config

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      | 139 ---------------------
 arch/arm/mach-shmobile/Kconfig                     |  13 --
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-bockw-reference.c     |  86 -------------
 7 files changed, 1 insertion(+), 244 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-bockw-reference.c

-- 
2.4.6

