From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 19 May 2014 23:37:14 +0000
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7790
Message-Id: <20140519233714.10496.31390.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140511232508.20177.11556.sendpatchset@w520>
In-Reply-To: <20140511232508.20177.11556.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARM: shmobile: Use shmobile_init_delay() on r8a7790

[PATCH 01/03] ARM: shmobile: Use r8a7790 DT CPU Frequency in common case	
[PATCH 02/03] ARM: shmobile: Use r8a7790 DT CPU Frequency for Lager
[PATCH 03/03] ARM: shmobile: Remove unused r8a7790_init_early()

Convert r8a7790 to rely on shmobile_init_delay() instead of using a per-SoC
delay setup function. Very similar to the r8a7791 implementation.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-v3.15-rc5-20140517

 arch/arm/mach-shmobile/board-lager-reference.c |    2 +-
 arch/arm/mach-shmobile/board-lager.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7790.h  |    1 -
 arch/arm/mach-shmobile/setup-r8a7790.c         |    9 +--------
 4 files changed, 3 insertions(+), 11 deletions(-)

