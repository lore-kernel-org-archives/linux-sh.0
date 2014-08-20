From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Aug 2014 14:32:29 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: dtsi: interrupt-parent cleanups
Message-Id: <CAMuHMdWFhqv5j8g8wGnaXBOZ7r7vBpOnW4K_KY7WAs04OYxQQg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1408544914-21742-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1408544914-21742-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Aug 20, 2014 at 4:28 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This series cleans up interrupt-parent use, to match common use.
> It makes sure there's an "interrupt-parent = <&gic>;" at the top, which is
> thus inherited by all child nodes, and removes superflous "interrupt-parent"
> properties from the individual child nodes.
>
> This was tested on r8a7791/koelsch only.
>
> Geert Uytterhoeven (4):
>   ARM: shmobile: r8a7779 dtsi: Remove superfluous interrupt-parent
>   ARM: shmobile: r8a7790 dtsi: Remove superfluous interrupt-parent
>   ARM: shmobile: r8a7790 dtsi: Remove superfluous interrupt-parent

Oops, that should have been "r8a7791". I've sent a fixed version of that patch.

>   ARM: shmobile: sh73a0 dtsi: Move interrupt-parent to the top

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
