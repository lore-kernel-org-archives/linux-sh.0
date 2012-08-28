From: Simon Horman <horms@verge.net.au>
Date: Tue, 28 Aug 2012 00:18:35 +0000
Subject: [GIT PULL] Renesas ARM-based SoC: KZM-9A-GT for 3.7
Message-Id: <1346113116-20252-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olaf, Hi Arnd,

please consider the following enhancement for the KZM-9A-GT board
from Tetsuyuki Kobayashi for inclusion in 3.7.

----------------------------------------------------------------
The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git kzm9g

for you to fetch changes up to 7952717adb69efc1d2443a1858f96d23c2fb93e0:

  ARM: shmobile: kzm9g: enable restarting (2012-08-25 14:39:44 +0900)

----------------------------------------------------------------
Tetsuyuki Kobayashi (1):
      ARM: shmobile: kzm9g: enable restarting

 arch/arm/mach-shmobile/board-kzm9g.c | 8 ++++++++
 1 file changed, 8 insertions(+)
