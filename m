From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 08 Apr 2013 02:52:18 +0000
Subject: Re: [RFC/PATCH 0/7] ARCH: shmobile: defconfig consolidation
Message-Id: <87mwt9ohsx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
 <87sj31omnz.wl%kuninori.morimoto.gx@renesas.com>
 <20130408021630.GI13103@verge.net.au>
In-Reply-To: <20130408021630.GI13103@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon

> > > Morimoto-san, I suspect it may be possible to add support for the
> > > bockw board to the consolidated defconfig if its boot loader supports
> > > booting using a zImage. In this case even though the base memory address
> > > is not the same as the boards above it should be possible to specify
> > > the base address from the boot loader. As I do not have a bockw board
> > > I am wondering if you could investigate this.
> > 
> > I tested shmobile_defconfig on Bock-W board.
> > It works with...
> > 
> >  1) I added R8A7778 SoC on .config
> >  2) I added Bock-W on .config
> >  3) I fixuped CONFIG_MEMORY_START, CONFIG_MEMORY_SIZE value on .config
> > 
> > It is correct method ?
> 
> Unfortunately not, the idea is not to modify CONFIG_MEMORY_START
> or CONFIG_MEMORY_SIZE.
> 
> My understanding is that if you load a zImage at the correct
> start address (0x60000000 IIRC) and then execute it using bootz
> then the kernel should relocate and run from that address.

Hmm...
This means 3) is not needed, but it didn't work without 3)
Is it R8A7778 or Bock-W DT code issue ?


Best regards
---
Kuninori Morimoto
