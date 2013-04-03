From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 03 Apr 2013 07:29:34 +0000
Subject: [RFC][PATCH 0/3] ARM: shmobile: r8a7790 clock update
Message-Id: <87ehescbs5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

These patches update r8a7790 clocks.
But, this is just information for you at this point.
Because current r8a7790 datasheet <--> real machine seems have mismatch
So, I added [RFC] on this series
I will re-send v2 if when got correct datasheet information

These are based on simon/next branch,
and, Rev 0.05 datasheet

Kuninori Morimoto (3):
      ARM: shmobile: r8a7790: add main clock
      ARM: shmobile: r8a7790: add div4 clocks
      ARM: shmobile: r8a7790: add div6 clocks

 arch/arm/mach-shmobile/clock-r8a7790.c |  209 +++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 5 deletions(-)



Best regards
---
Kuninori Morimoto
