From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2015 11:59:32 +0000
Subject: Re: [PATCH/RFC 10/10] Local: Hack: arm64: dts: r8a7795: add ravb phy max-speed 100 for Salvator-X bo
Message-Id: <CAMuHMdUMyuM_p+VZm85gkr-xDCak1OHyxcO82Q-kQKQTyxxRiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 1:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Aug 27, 2015 at 06:24:10PM +0900, Simon Horman wrote:
>> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>>
>> This is a work-around for limitations in the driver implementation.
>
> I know this is marked "local: hack:", still: If this is a driver
> limitation, shouldn't it rather be in the dtsi then?

You mean, in the driver?

DT decribes the hardware, not driver limitations.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
