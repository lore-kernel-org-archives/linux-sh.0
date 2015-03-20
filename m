From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 20 Mar 2015 12:30:35 +0000
Subject: [PATCH 0/3] bockw SD pull-ups
Message-Id: <1426854638-9187-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This series implements pull-up configuration in the r8a7778 PFC driver
and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
replacing the hack that is used in the legacy platforms.

CU
Uli


Ulrich Hecht (3):
  pinctrl: sh-pfc: add macros defining GP ports with config flags
  pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
  ARM: shmobile: bockw dts: define sdhi0 pins with pull-ups

 arch/arm/boot/dts/r8a7778-bockw.dts  |  10 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 259 ++++++++++++++++++++++++++++++++---
 drivers/pinctrl/sh-pfc/sh_pfc.h      |  47 ++++---
 3 files changed, 270 insertions(+), 46 deletions(-)

-- 
2.2.2

