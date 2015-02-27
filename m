From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 27 Feb 2015 01:25:48 +0000
Subject: [GIT PULL] SH Drivers Updates for v4.0
Message-Id: <cover.1425000135.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>

Hi Linus,

Please consider these SH drivers updates for v4.0.

I am sending this change after v4.0-rc1 has been released
as it depends on r8a7740 SoC changes which are present in that rc release.

I expect some more minor updates to the same file during the v4.1 release cycle
to reflect changes to other SoCs.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-drivers-for-v4.0

for you to fetch changes up to a5cb514f1f689a48595370a368b568e2f551ddfd:

  drivers: sh: Disable PM runtime for multi-platform r8a7740 with genpd (2015-02-24 07:26:12 +0900)

----------------------------------------------------------------
SH Drivers Updates for v4.0

* Disable PM runtime for multi-platform r8a7740 with genpd

----------------------------------------------------------------
Geert Uytterhoeven (1):
      drivers: sh: Disable PM runtime for multi-platform r8a7740 with genpd

 drivers/sh/pm_runtime.c | 2 ++
 1 file changed, 2 insertions(+)
