From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 05 Oct 2015 14:55:52 +0000
Subject: [PATCH v3 0/3] bockw SD pull-ups
Message-Id: <1444056955-8836-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This series implements pull-up configuration in the r8a7778 PFC driver
and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
replacing the hack that is used in the legacy platforms.

This version returns from the bias methods without doing any I/O if a pin
is undefined; thanks to Laurent for pointing this out.  It also includes
the various Acks.

CU
Uli


Changes since v2:
- return from get_bias/set_bias without doing I/O if a pin is undefined
- added Acks etc.

Changes since v1:
- use bitfields for pull-up table
- WARN_ON_ONCE instead of BUG_ON on undefined pull-ups


Ulrich Hecht (3):
  pinctrl: sh-pfc: add macros defining GP ports with config flags
  pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
  ARM: shmobile: bockw dts: define sdhi0 pins with pull-ups

 arch/arm/boot/dts/r8a7778-bockw.dts  |  10 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 263 ++++++++++++++++++++++++++++++++---
 drivers/pinctrl/sh-pfc/sh_pfc.h      |  47 ++++---
 3 files changed, 274 insertions(+), 46 deletions(-)

-- 
2.6.0

