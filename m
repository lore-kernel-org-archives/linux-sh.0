From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:40:40 +0000
Subject: [PATCH 0/5] ARM: shmobile: sharing gpio functions
Message-Id: <87mx3rk72z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael, Magnus
Cc Simon

These patch set try to sharing extra gpio functions on SH-ARM.
These depends on my rework patch-set

Kuninori Morimoto (5):
      ARM: shmobile: add common extra gpio functions
      ARM: shmobile: use common extra gpio functions on ap4evb
      ARM: shmobile: use common extra gpio functions on g4evm
      ARM: shmobile: use common extra gpio functions on mackrel
      ARM: shmobile: use common extra gpio functions on armadillo800eva
