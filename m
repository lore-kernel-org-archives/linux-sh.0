From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:42:34 +0000
Subject: [PATCH 0/4] ARM: shmobile: sharing DMAEngine
Message-Id: <87ehp3k6zt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael, Magnus
Cc Simon

These patch set try to sharing DMAEngine on SH-ARM.
These depends on my rework patch set

Kuninori Morimoto (4):
      ARM: shmobile: add common DMAEngine definitions
      ARM: shmobile: use common DMAEngine definitions on r8a7740
      ARM: shmobile: use common DMAEngine definitions on sh7372
      ARM: shmobile: use common DMAEngine definitions on sh73a0
