From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Oct 2015 07:25:59 +0000
Subject: Re: Salvator-X I2C is working on HI speed on renesas-drivers-2015-10-27-v4.3-rc7
Message-Id: <CAMuHMdUoF8LbevgCD+0x5siy66vs0jWOKAceshVpQO_y8qN65g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fm61988.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Oct 29, 2015 at 7:31 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> I'm debugging renesas-drivers-2015-10-27-v4.3-rc7 yesterday/today
> and I noticed that I2C doesn't work on Salvator-X
>
> Sound needs Codec/CS2000, these both needs I2C access.
> But, it gets -ENXIO from bus.
> At least it works on renesas-drivers-2015-09-29-v4.3-rc3.
>
> In my debug, it seems I2C SCL/SDA speed on 10-27 is very HI.
> (I checked this via CN27 73/74pin)
> But, i2c clock on /sys/kernel/debug/clk/clk_summary in 09-29 <-> 10-27
> seems same value.
>
> Where should I check ?

Does it work if you revert commit 2bc3c5a8631db6d8 ("i2c: rcar: init new
messages in irq")?
That commit was reported by Laurent to break HDMI on Koelsch, cfr.
http://www.spinics.net/lists/linux-sh/msg46160.html.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
