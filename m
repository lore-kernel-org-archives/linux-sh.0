From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 01:59:13 +0000
Subject: [PATCH 0/1 v3] clk: CS2000 support
Message-Id: <87fv2c1ogc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

H3 Salvator-X need to use CS2000 as sound clock
This patch is already posted, but not yet merged
http://thread.gmane.org/gmane.linux.kernel.clk/354

Kuninori Morimoto (1):
      clk: add CS2000 Fractional-N driver

 Documentation/devicetree/bindings/clock/cs2000-cp.txt |  24 +++++
 drivers/clk/Kconfig                                   |   6 ++
 drivers/clk/Makefile                                  |   1 +
 drivers/clk/clk-cs2000-cp.c                           | 530 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 561 insertions(+)

Best regards
---
Kuninori Morimoto
