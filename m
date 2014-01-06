From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 06 Jan 2014 08:32:12 +0000
Subject: [PATCH 0/2] ARM: shmobile: r8a7790: add Audio-DMAC support
Message-Id: <871u0ljyt2.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches add Audio DMAC support on r8a7790.
These are used from R-Car sound driver.

Current Simon's branch doesn't have R-Car
sound driver support, since it needs ASoC branch merge.
(= it has Gen2 support)
But, this DMAEngine support can be applied without
sound driver support.

These are based on renesas-devel-v3.13-rc5-20131230 tag

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: add Audio DMAC clock
      ARM: shmobile: r8a7790: add Audio DMAC support

 arch/arm/mach-shmobile/clock-r8a7790.c        |    5 ++
 arch/arm/mach-shmobile/include/mach/r8a7790.h |   25 +++++++
 arch/arm/mach-shmobile/setup-r8a7790.c        |   90 +++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

Best regards
---
Kuninori Morimoto
