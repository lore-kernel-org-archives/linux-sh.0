From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Sep 2015 09:48:19 +0000
Subject: Re: [PATCH 14/14][RFC] arm64: defconfig: add CS2000 driver support
Message-Id: <CAMuHMdUxaeN72WJ9_aS2kJjrNF+TMv7m3VzgDFEZUjZ=J9rLjQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87si6mn452.wl%kuninori.morimoto.gx@renesas.com>
 <87613in3sc.wl%kuninori.morimoto.gx@renesas.com>
 <CAMuHMdWXw+sOudjGOcJzctaRVH9L1c6eotGmHgsEjUXdhUvvEQ@mail.gmail.com>
 <87oahalijm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oahalijm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Morimoto-san,

On Thu, Sep 10, 2015 at 11:43 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> <kuninori.morimoto.gx@renesas.com> wrote:
>> > --- a/arch/arm64/configs/defconfig
>> > +++ b/arch/arm64/configs/defconfig
>> > @@ -82,6 +82,7 @@ CONFIG_DEVTMPFS_MOUNT=y
>> >  CONFIG_DMA_CMA=y
>> >  CONFIG_BLK_DEV_LOOP=y
>> >  CONFIG_VIRTIO_BLK=y
>> > +CONFIG_CS2000_CP=y
>>
>> =m?
>
> not sure. no one is selecting =m on defconfig ?

I guess the arm64 kernel binaries are still small ;-)

> It seems ARM ML topic ?

Yes. But for arm32, the arm-soc maintainers prefer modules where
appropriate (i.e. for anything not critical for booting).

Let's ask (cfr. CC).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
