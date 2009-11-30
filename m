From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 30 Nov 2009 04:21:45 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: update ecovec24 defconfig
Message-Id: <ueingd4me.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> > I change cache configuration 
> > because currect kernel can not use CONFIG_CACHE_WRITEBACK
> > 
> Uhm, why not? Where is the bug report on this?

Oops sorry.
I reported it but private mail...
2009/10/15 "Question about boot on EcoVec"

> what is wrong with "write back" / "copy back"?

If I use CONFIG_CACHE_WRITEBACK, it will hung up
when user-side "init" start

Best regards
--
Kuninori Morimoto
 
