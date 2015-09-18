From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 01:55:47 +0000
Subject: [PATCH 0/2 v3] i2c: rcar: r8a7795 support
Message-Id: <87mvwk1om3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

These are already posted by Wolfram in
http://thread.gmane.org/gmane.linux.ports.sh.devel/47665

But not yet merged in topic branch (?)
So, I send this serias. Sound doesn't work without these patches

Wolfram Sang (2):
      i2c: rcar: add support for r8a7795 (R-Car H3)
      i2c: sh_mobile: add support for r8a7795 (R-Car H3)

 Documentation/devicetree/bindings/i2c/i2c-rcar.txt      | 1 +
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 1 +
 drivers/i2c/busses/i2c-rcar.c                           | 3 +++
 drivers/i2c/busses/i2c-sh_mobile.c                      | 1 +
 4 files changed, 6 insertions(+)

Best regards
---
Kuninori Morimoto
