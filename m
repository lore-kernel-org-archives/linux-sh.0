From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Nov 2011 02:59:22 +0000
Subject: [PATCH 0/2] sh: bugfix: sh7724/sh7723 boot on paul/hwblk
Message-Id: <87zkfoyi9l.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul
Cc Guennadi

These are bugfix patches for sh7724/sh7723 boot on paul/hwblk branch

Kuninori Morimoto (2):
      sh: sh7724.h: bugfix: remove unused clock index
      sh: sh7723.h: bugfix: remove unused clock index

Now it doesn't use hwblk, but it still have un-needed HWBLK_xxx index
which are not set by SH_CLK_MSTP32() macro.
So, sh7724/sh7723 boot will be crash, because clk.enable_reg = NULL on such clocks.

I tested it on Ecovec (sh7724) and ALGO (sh7723) board.
I don't have sh7722 board now.

Best regards
---
Kuninori Morimoto
