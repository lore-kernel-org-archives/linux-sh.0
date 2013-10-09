From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 09 Oct 2013 06:51:24 +0000
Subject: [GIT PULL] Second Round of Renesas ARM based SoC defconfig updates for v3.13
Message-Id: <cover.1381300141.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd, Hi Kevin,

please consider this second round of Renesas ARM based SoC defconfig
updates for v3.13.


The following changes since commit 6bb2e347899b297eea26f2658eac8fdcd633fba5:

  ARM: shmobile: Add koelsch defconfig (2013-09-20 17:46:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v3.13

for you to fetch changes up to bb416e1d7416861bece0335f543c590d9af09c79:

  ARM: shmobile: Genmai defconfig (2013-10-03 13:01:30 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC defconfig updates for v3.13

* Add defconfig for Genmai board

----------------------------------------------------------------
Magnus Damm (1):
      ARM: shmobile: Genmai defconfig

 arch/arm/configs/genmai_defconfig | 116 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 arch/arm/configs/genmai_defconfig
