From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Mar 2014 06:29:56 +0000
Subject: [PATCH 0/2] ARM: shmobile: koelsch, lager: Annotate clk_names with __initconst
Message-Id: <1394692198-30715-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add __initconst annotations to recently added clk_names.

Depends on
"[PATCH v2 00/03] ARM: shmobile: Break out and extend clock workaround V2"

Simon Horman (2):
  ARM: shmobile: koelsch: Annotate clk_names with __initconst
  ARM: shmobile: lager: Annotate clk_names with __initconst

 arch/arm/mach-shmobile/board-koelsch-reference.c | 2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.5.2

