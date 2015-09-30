From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Sep 2015 06:51:38 +0000
Subject: Re: [PATCH] ARM: shmobile: porter: initial device tree
Message-Id: <CAMuHMdV9HXHiRPWMKW_c2mHinjuvioRxU2aq7202H+_X4TFTpg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <2022535.FYlSB7sRz4@wasted.cogentembedded.com>
In-Reply-To: <2022535.FYlSB7sRz4@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Sergei,

On Wed, Sep 30, 2015 at 1:26 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the initial device tree for the R8A7791 SoC based Porter low cost board
> (which  is a  slightly modified version  of the Henninger board).

Can you please tell us more about the differences?
It will help us reviewing future DTS updates.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

If you update Documentation/devicetree/bindings/arm/shmobile.txt, you can
add my
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
