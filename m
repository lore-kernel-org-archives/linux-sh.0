From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 06 Aug 2013 06:11:56 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: remove nfsroot settings
Message-Id: <87haf3gxg6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-4-git-send-email-horms+renesas@verge.net.au>
 <87bo5h3lb3.wl%kuninori.morimoto.gx@renesas.com>
 <20130801080226.GF15265@verge.net.au>
 <20130806010736.GA20940@verge.net.au>
 <87r4e7h88z.wl%kuninori.morimoto.gx@renesas.com>
 <20130806022955.GA25114@verge.net.au>
 <87pptrh6f3.wl%kuninori.morimoto.gx@renesas.com>
 <87ob9bh5mt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ob9bh5mt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon again

> > Yes, I can send patches.
> > But, I can't test emev2-kzm9d board.
> > Do you have it ?
> 
> These patches remove nfsroot settings from kzm9d/armadillo dts file.
> I tested #1 patch on Armadillo board, but I don't have kzm9d board.

I could test kzm9d board on Magnus's environment.
It works well without "rsize/wsize"

Best regards
---
Kuninori Morimoto
