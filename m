From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:31:49 +0000
Subject: [PATCH 00/03] ARM: shmobile: EMEV2 init delay update
Message-Id: <20140605053149.19066.90593.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: EMEV2 init delay update

[PATCH 01/03] ARM: shmobile: Update EMEV2 DTS to include CPU frequency
[PATCH 02/03] ARM: shmobile: Use shmobile_init_delay() on EMEV2
[PATCH 03/03] ARM: shmobile: Get rid of redundant EMEV2 mach callbacks

These patches clean up the EMEV2 SoC code. The CPU Frequency is put into
DTS, code is adjusted to read out the frequency from DTS, and the EMEV2
SoC callbacks are cleaned up slightly.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written last week on top of renesas-devel-v3.15-rc7-20140528 but
 applies cleanly on top of renesas-devel-v3.15-rc8-20140605.

 arch/arm/boot/dts/emev2.dtsi         |    2 ++
 arch/arm/mach-shmobile/setup-emev2.c |   17 ++---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

