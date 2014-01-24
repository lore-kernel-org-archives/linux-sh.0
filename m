From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 24 Jan 2014 01:14:23 +0000
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Fixes for v3.14
Message-Id: <cover.1390525593.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider this second round of renesas ARM Based SoC DT fixes for v3.14.

This pull-request is based on the first round of such fixes,
tagged as renesas-dt-fixes-for-v3.14, which you have previously pulled.


The following changes since commit 3effae8c26f451a9d572255c08dfbe342dd1dc98:

  Revert "ARM: shmobile: r8a7791: Add SSI clocks in device tree" (2013-12-26 14:16:54 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-fixes2-for-v3.14

for you to fetch changes up to 2450badfc19b67340d3570665cc02a22df03dfab:

  ARM: shmobile: r8a7790.dtsi: ficx i2c[0-3] clock reference (2014-01-21 09:45:50 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Fixes for v3.14

Correct i2c clock references for r8a7790 (R-Car H2) SoC

The error was introduced in 72197ca7a1cb1cea5 ("ARM: shmobile: r8a7790:
Reference clocks") which is queued up for v3.14.

----------------------------------------------------------------
Ben Dooks (1):
      ARM: shmobile: r8a7790.dtsi: ficx i2c[0-3] clock reference

 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
