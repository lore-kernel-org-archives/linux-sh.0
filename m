From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Feb 2014 07:41:10 +0000
Subject: [PATCH 00/02] ARM: shmobile: Koelsch SDHI DT support
Message-Id: <20140212074110.23493.41073.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Koelsch SDHI DT support

[PATCH v2 01/02] ARM: shmobile: Add SDHI devices to r8a7791 DTSI
[PATCH 02/02] ARM: shmobile: Add SDHI devices for Koelsch DTS

Add SDHI devices to the Koelsch DT board support. The same run
time dependencies as SDHI for Lager applies here too, and there
is a PFC fix for SD1_CLK that is needed for r8a7791 as well.

Can be merged independently without waiting for v3.15 patches.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.14-rc1-20140207

 Requires the following patch for correct run time operation:
 [PATCH 02/03] pinctrl: sh-pfc: r8a7791: SD1_CLK fix

 arch/arm/boot/dts/r8a7791-koelsch.dts |  131 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi        |   27 ++++++
 2 files changed, 158 insertions(+)
