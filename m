From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Nov 2013 07:59:21 +0000
Subject: [PATCH 00/05] ARM: shmobile: r8a7790 and r8a7791 thermal update
Message-Id: <20131120075921.23557.23231.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, horms@verge.net.au, linux-sh@vger.kernel.org

ARM: shmobile: r8a7790 and r8a7791 thermal update

[PATCH 01/05] ARM: shmobile: Add r8a7790 thermal device node to DTS
[PATCH 02/05] ARM: shmobile: Add r8a7790 clocks for thermal devices
[PATCH 03/05] ARM: shmobile: Add r8a7791 thermal device node to DTS
[PATCH 04/05] ARM: shmobile: Add r8a7791 thermal platform device
[PATCH 05/05] ARM: shmobile: Add r8a7791 clocks for thermal devices

Update the thermal support for the r8a7790 and the r8a7791 SoCs. As
usual the code is split between the DT reference code and the legacy
case. The DT reference code is written to be multiplatform aware and
is used to point out the future direction. Hardware support may however
be limited there due to lacking DT bindings.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.12-20131119

 Tested on Lager and Koelsch.

 arch/arm/boot/dts/r8a7790.dtsi         |    7 +++++++
 arch/arm/boot/dts/r8a7791.dtsi         |    7 +++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |    1 +
 arch/arm/mach-shmobile/clock-r8a7791.c |    4 ++++
 arch/arm/mach-shmobile/setup-r8a7791.c |   12 ++++++++++++
 5 files changed, 31 insertions(+)
