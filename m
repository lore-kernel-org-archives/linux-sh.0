From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Feb 2014 04:25:52 +0000
Subject: [PATCH 00/03] ARM: shmobile: Koelsch legacy SDHI support
Message-Id: <20140212042552.10516.10308.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Koelsch legacy SDHI support

[PATCH 01/03] ARM: shmobile: Add r8a7791 legacy SDHI clocks
[PATCH 02/03] pinctrl: sh-pfc: r8a7791: SD1_CLK fix
[PATCH 03/03] ARM: shmobile: Add SDHI devices for legacy Koelsch

Add SDHI devices to the legacy Koelsch board support. While at it
fix missing PFC bits for SDHI1 and also add legacy clocks. Each
of the patches can be merged independently without compile
failure, but all of them are required for correct SDHI run time
operation on the Koelsch board. Next step is DTSI and DTS which
will be handled in a separate series.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch.c |  155 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7791.c |   51 ++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c   |    6 -
 3 files changed, 208 insertions(+), 4 deletions(-)
