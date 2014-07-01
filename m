From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 01 Jul 2014 00:28:08 +0000
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Defconfig Updates for v3.17
Message-Id: <cover.1404172763.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Second Round of Renesas ARM Based SoC Defconfig
Updates for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig-for-v3.17,
which I have already sent a pull-request for.


The following changes since commit 468c570ed078f0326745bfe85868adb925659502:

  ARM: shmobile: Enable CPUFREQ configuration (2014-06-16 19:44:34 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-defconfig2-for-v3.17

for you to fetch changes up to c61010050d3baa3e1a3964bec7e62437d21107c6:

  ARM: shmobile: Enable genmai board in multiplatform defconfig (2014-06-25 16:46:31 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Defconfig Updates for v3.17

* Enable genmai board in multiplatform defconfig

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: Enable genmai board in multiplatform defconfig

 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)
