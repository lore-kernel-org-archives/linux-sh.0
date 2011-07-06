From: kuninori.morimoto.gx@renesas.com
Date: Wed, 06 Jul 2011 01:17:17 +0000
Subject: [RFC][PATCH 0/8] sh: clock-shxxxx: add CLKDEV_ICK_ID for cleanup
Message-Id: <87vcvgjjhj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Magnus

These are not so important, but are clean-up patches.
Current clock-shxxxx are a little bit un-readable.
I put it as [RFC]

Kuninori Morimoto (8):
      sh: clock-sh7724: add CLKDEV_ICK_ID for cleanup
      sh: clock-sh7722: add CLKDEV_ICK_ID for cleanup
      sh: clock-sh7343: add CLKDEV_ICK_ID for cleanup
      sh: clock-sh7366: add CLKDEV_ICK_ID for cleanup
      sh: clock-sh7757: add CLKDEV_ICK_ID for cleanup
      sh: clock-sh7785: add CLKDEV_ICK_ID for cleanup
      sh: clock-sh7786: add CLKDEV_ICK_ID for cleanup
      sh: clock-shx3: add CLKDEV_ICK_ID for cleanup

I checked sh7724, but couldn't others.


Best regards
---
Kuninori Morimoto
