From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 29 Oct 2013 08:57:29 +0000
Subject: [PATCH 0/2] ARM: shmobile: lager, koelsch: set .debounce_interval
Message-Id: <1383037051-21427-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This short series sets .debounce_interval for GPIO keys
for the lager and koelsch boards.

This resolves a problem on the lager board reported, tested and fixed by
Kuribayashi-san.  I have extended the solution to the koelsch board.

Shinya Kuribayashi (1):
  ARM: shmobile: lager: set .debounce_interval

Simon Horman (1):
  ARM: shmobile: koelsch: set .debounce_interval

 arch/arm/mach-shmobile/board-koelsch.c | 3 ++-
 arch/arm/mach-shmobile/board-lager.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.8.4

