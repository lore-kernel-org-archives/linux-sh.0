From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Mar 2012 08:04:28 +0000
Subject: Re: Migo-R (SH7722) vs. NUMA
Message-Id: <87399jbjsn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8762egpvhn.fsf@schwinge.name>
In-Reply-To: <8762egpvhn.fsf@schwinge.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Thomas

> > I forgot detail of MIGO-R.
> > But in my quick check,
> > my MIGO-R .config doesn't have CONFIG_NUMA since around v2.6.32-rc5
> 
> Hmm, where do you see/check that?
> 
>     $ git blame -L /^CONFIG_NUMA/,+1 v3.2 -- arch/sh/configs/migor_defconfig 
>     70f784ec (Magnus Damm 2008-02-07 00:38:24 +0900 16) CONFIG_NUMA=y

Ahh.. sorry for my confusion.
It was not migor_defconfig.
It is my local .config series which worked correctly on migo-r each linux version :)
unfortunately (?) defconfig sometimes doesn't work...

Best regards
---
Kuninori Morimoto
