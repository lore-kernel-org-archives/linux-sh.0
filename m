From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Apr 2013 01:57:07 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: bockw: enable boot from shmobile_defconfig
Message-Id: <87r4ijjggf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365131070-13142-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365131070-13142-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > To enable boot from shmobile_defconfig on Bock-W,
> > it needs
> >  - memory started from 0x40000000
> >  - enable R8A7778
> >  - enable Bock-W board
> >  - enable TMU
> 
> I was expecting that the bockw needed to be started at 0x600000000.
> Are there any side-effects of using 0x400000000?

Actually, I'm not good at shmobile_defconfig boot approach detail.
But my understanding is that shmobile_defconfig binary is
assuming Linux kernel is located from 0x400000000 (= CONFIG_MEM_xxx),
and dts :: memory can remap (?) memory if it was 0x400000000 ?

Bock-W couldn't boot if I used 0x600000000 on dts :: memory

> If not, then I guess I am happy with this.
> But could you split it into two patches?

OK, thank you

Best regards
---
Kuninori Morimoto
