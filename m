From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Aug 2015 07:42:33 +0000
Subject: Re: [PATCH/RFC 05/10] arm64: dts: r8a7795: add clock for EthernetAVB
Message-Id: <CAMuHMdWM-hf3S06SncW4Fe2zzZGF4BfJwT1TXPrjtQ=STFw6dQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-6-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-6-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 28, 2015 at 1:47 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Maybe this is my v7 fault, but we need to use "clock-indices" instead of "renesas,clock-indices".
> I will fix these in next v8

Woops, and we kept on copying that ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
