From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Jun 2014 07:30:09 +0000
Subject: Re: [PATCH 3/3 v3] ARM: shmobile: lager: add sound support on DT
Message-Id: <CAMuHMdWc9FV-y1oAnvtmCQiAipcrz2e1ZpRkMNcn_a_8vS-M7A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a99kj5q2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a99kj5q2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wed, Jun 11, 2014 at 8:54 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> +               compatible = "asahi-kasei,ak4643";

As Sergei already commented,
Documentation/devicetree/bindings/vendor-prefixes.txt
says

        ak      Asahi Kasei Corp.

Gr{oetje,eeting}s,


                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
