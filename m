From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Jan 2014 08:33:49 +0000
Subject: Re: [PATCH] shdma: add R-Car Audio DMAC peri peri driver
Message-Id: <CAMuHMdWHSigAGx6EtFp_Em8Qw-jt2E-o79ORoTWe=MdwZmF5pw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uu6gle8.wl%kuninori.morimoto.gx@gmail.com>
	<CAMuHMdX14rktzRtV9bqHFHZV6bsmQ_k=vAZFaPeNjcJsWeX42w@mail.gmail.com>
	<871tzxg5d1.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <871tzxg5d1.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Morimoto-san,

On Fri, Jan 24, 2014 at 9:18 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>> > +       if (slave_id >= AUDMAPP_SLAVE_NUMBER)
>>
>> So slave_id should be unsigned int, too, and AUDMAPP_SLAVE_NUMBER
>> too ("29U").
>
> Hmm...
> This driver is called from shdma-base.c.
> And shdmac.c/sudmac.c/rcar-hpbdmac.c are same style.
>
>  1) this "slave_id" came from shdma_ops::set_slave
>     and, it is using "int"
>  2) above drivers have same xxx_find_slave(),
>     they are using "int".
>     (this driver is based on that)
>
> What should I do ?

OK, then you should keep using int, and change the test to:

    if (slave_id < 0 || slave_id >= AUDMAPP_SLAVE_NUMBER)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
