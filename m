From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 10 Nov 2014 01:32:11 +0000
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v3.19
Message-Id: <cover.1415582943.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v3.19.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.19

for you to fetch changes up to ccde0fbd4fe88151c8d3a93a3e3a939a0a1753b2:

  ARM: shmobile: multiplatform: add AK4642 support on defconfig (2014-11-05 14:47:56 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v3.19

* Enable AK4642, Audo DMAC peri peri and R-Car DMAC in shmobile defconrig
* Enable PM Runtime in ape6evm defconfig

----------------------------------------------------------------
Kuninori Morimoto (3):
      ARM: shmobile: multiplatform: add R-Car DMAC support on defconfig
      ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
      ARM: shmobile: multiplatform: add AK4642 support on defconfig

Simon Horman (1):
      ARM: shmobile: ape6evm: Enable PM Runtime in defconfig

 arch/arm/configs/ape6evm_defconfig  | 1 +
 arch/arm/configs/shmobile_defconfig | 3 +++
 2 files changed, 4 insertions(+)
