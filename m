From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:43:21 +0000
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v3.20
Message-Id: <cover.1419808942.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v3.20.


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.20

for you to fetch changes up to db54d850b686c2ca81c10dd3582e98ee089a0e3a:

  ARM: shmobile: Enable DA9063 watchdog in multiplatform defconfig (2014-12-21 16:53:36 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v3.20

* Enable DA9063, MICREL_PHY and MTD_BLOCK watchdog in multiplatform defconfig
* Update AK8975 config option in kzm9g defconfig

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: kzm9g_defconfig: Update AK8975 config option
      ARM: shmobile: Enable MICREL_PHY in shmobile_defconfig
      ARM: shmobile: Enable DA9063 watchdog in multiplatform defconfig

Kuninori Morimoto (2):
      ARM: shmobile: defconfig: cleanup by savedefconfig
      ARM: shmobile: defconfig: add MTD_BLOCK

 arch/arm/configs/kzm9g_defconfig    |  2 +-
 arch/arm/configs/shmobile_defconfig | 30 ++++++++++++++----------------
 2 files changed, 15 insertions(+), 17 deletions(-)
