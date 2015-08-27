From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2015 13:05:23 +0000
Subject: Re: [PATCH/RFC 08/10] arm64: dts: r8a7795: enable nfs root on Salvator-X board
Message-Id: <CAMuHMdU3OKDuS8K=Sw0koMWShiy0kBu5i_obF=NL1Y8VXHpGfg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-9-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-9-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 2:54 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 8/27/2015 2:58 PM, Geert Uytterhoeven wrote:
>
>>>     Hm... so this SoC doesn't have the plain Ether device, just AVB?
>
>
>> Indeed.
>
>
>    Indeed, yes? Or was this to reiterate the question? :-)

Indeed yes. R8a7795 has only ravb, not sh_eth.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
