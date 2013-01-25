From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Jan 2013 02:17:26 +0000
Subject: [GIT PULL] Renesas ARM-based SoC boards for v3.9
Message-Id: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1350448761-27346-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1350448761-27346-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following board enhancements for 3.9.

----------------------------------------------------------------
The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to 42dd581bc4dba82e8756bb881fa974742250b4c6:

  ARM: shmobile: Include sh73a0 DTSI in kzm9g (2013-01-25 09:26:33 +0900)

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: mackerel: include the correct .dtsi file

Kuninori Morimoto (3):
      ARM: shmobile: fix sample amixer settings for mackerel
      ARM: shmobile: add sample amixer settings for ap4evb
      ARM: shmobile: add sample amixer settings for armadillo800eva

Laurent Pinchart (2):
      ARM: shmobile: kzm9g: Use of_machine_is_compatible()
      ARM: shmobile: Include sh73a0 DTSI in kzm9g

Nobuhiro Iwamatsu (1):
      ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva

 arch/arm/boot/dts/r8a7740-armadillo800eva.dts  |    2 +-
 arch/arm/boot/dts/sh7372-mackerel.dts          |    2 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts             |    2 +-
 arch/arm/mach-shmobile/board-ap4evb.c          |    4 ++++
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 ++++++++
 arch/arm/mach-shmobile/board-kzm9g.c           |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c        |    4 +---
 7 files changed, 17 insertions(+), 7 deletions(-)
