From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Jan 2013 02:02:52 +0000
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.9 #2
Message-Id: <1359079374-25032-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1350448698-26985-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1350448698-26985-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following defconfig enhancements for 3.9.

This series is based on the renesas/defconfig branch in the arm-soc tree.

----------------------------------------------------------------
The following changes since commit 8098df15c26b2bf16924df5a134d1a649692ab62:

  ARM: mach-shmobile: kzm9d: update defconfig (2013-01-15 08:57:09 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git defconfig2

for you to fetch changes up to 46bbd43fa44fe083188f3e4846ba5b8d3c89bae6:

  ARM: mach-shmobile: mackerel:  enable VFP in defconfig (2013-01-23 14:59:37 +0900)

----------------------------------------------------------------
Simon Horman (2):
      ARM: mach-shmobile: armadillo: defconfig: Enable CEU
      ARM: mach-shmobile: mackerel:  enable VFP in defconfig

 arch/arm/configs/armadillo800eva_defconfig |    5 +----
 arch/arm/configs/mackerel_defconfig        |    1 +
 2 files changed, 2 insertions(+), 4 deletions(-)
