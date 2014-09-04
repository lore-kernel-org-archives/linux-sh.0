From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Sep 2014 02:28:35 +0000
Subject: [PATCH 00/03] ARM: shmobile: sh73a0 and kzm9g Multiplatform support
Message-Id: <20140904022835.26216.90336.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: sh73a0 and kzm9g Multiplatform support

[PATCH 01/03] ARM: shmobile: sh73a0: Introduce generic setup callback
[PATCH 02/03] ARM: shmobile: sh73a0: Add Multiplatform support
[PATCH 03/03] ARM: shmobile: kzm9g: Build DTS for Multiplatform

This patch series enables sh73a0 Multiplatform support. At this point
the KZM9G board code is left as-is, but future updates will make
sure to consolidate the DTS and get rid of C board code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20140904-v3.17-rc3
 
 arch/arm/boot/dts/Makefile            |    3 ++-
 arch/arm/mach-shmobile/Kconfig        |    5 +++++
 arch/arm/mach-shmobile/Makefile       |    4 ++--
 arch/arm/mach-shmobile/setup-sh73a0.c |   21 +++++++++++++++++----
 4 files changed, 26 insertions(+), 7 deletions(-)

