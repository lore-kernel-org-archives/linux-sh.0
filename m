From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Oct 2011 03:00:25 +0000
Subject: [PATCH 0/5] ARM: mach-shmobile: r8a7740: INTCA/INTCS support
Message-Id: <87hb342wqi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul, Magnus, SH ML members

These are r8a7740/bonito INTCA/INTCS support patch set

Kuninori Morimoto (5):
      ARM: mach-shmobile: r8a7740: use INTC instead of GIC
      ARM: mach-shmobile: bonito: make sure static function
      ARM: mach-shmobile: bonito: fixup fpga_write()
      ARM: mach-shmobile: add FPGA irq demux
      ARM: mach-shmobile: add SMSC9221 support

Best regards
---
Kuninori Morimoto
