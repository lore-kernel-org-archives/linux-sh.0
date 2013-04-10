From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Apr 2013 05:27:11 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: bockw: enable boot from shmobile_defconfig
Message-Id: <87k3obj6qb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365131070-13142-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365131070-13142-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> If the uboot on the bockw supports zImage then it should
> be possible to load an image built with shmobile_defconfig
> at 0x600000000 and execute it there.
> 
> Something like this:
> 
> dhcp
> tftp 60000000 bockw/zImage
> tftp 60f00000 bockw/r8a7778-bockw.dtb
> bootz 60000000 - 60f00000

Hmm...
I tried above, but BockW couldn't boot...

Best regards
---
Kuninori Morimoto
