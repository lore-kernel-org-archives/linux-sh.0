From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 26 Nov 2009 08:37:58 +0000
Subject: Re: currect MigoR seems doesn't work
Message-Id: <ufx81of4p.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul
[Cc Magnus]

> start_kernel
>  setup_arch
>   setup_memory
>    setup_bootmem_allocator
>     for()
>       reserve_bootmem (when i=2 I think)
>        mark_bootmem
>         BUG()          <= dead here and reboot MigoR
(snip)
> > It start works if I remove NUMA support from .config
> > 
> Thanks for testing, I'll look in to fixing it up.

Now, I got same phenomenon on EcoVec
which is mass production board.

46/50 board are working,
but 4/50 are can not work if It is romImage.
But it works If I use net boot.

My .config doesn't have NUMA support now.
Do you have any doubtful point ?

Best regards
--
Kuninori Morimoto
 
