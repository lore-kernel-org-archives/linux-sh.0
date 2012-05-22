From: kuninori.morimoto.gx@renesas.com
Date: Tue, 22 May 2012 02:33:45 +0000
Subject: [PATCH 0/2] ARM: mach-shmobile: kzm9g: add FSI support
Message-Id: <871umdaqrd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus
Cc Simon

The necessary missing patches for kzm9g will be merged on v3.5 kernel.
These are ASoC
(and already exists on linux-next tree)

These patch set add FSI sound support to kzm9g board for v3.5 kernel.

Kuninori Morimoto (2):
      ARM: mach-shmobile: clock-sh73a0: add FSI clock
      ARM: mach-shmobile: kzm9g: add FSI-AK4648 support
