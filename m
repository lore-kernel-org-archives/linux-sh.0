From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2014 09:04:20 +0000
Subject: Re: [PATCH 0/3] sh_eth: Remove redundant alignment adjustment
Message-Id: <CAMuHMdVm9_gUToUjgFh4SwrfxzBvzHcNDb+CNkKyaz6mcT2AJg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415862301-28032-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1415862301-28032-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Kaneko-san,

On Thu, Nov 13, 2014 at 8:04 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> This series is based on net tree.
>
> Mitsuhiro Kimura (3):
>   sh_eth: Remove redundant alignment adjustment
>   sh_eth: Fix skb alloc size and alignment adjust rule.
>   sh_eth: Fix dma mapping issue

Thanks!

I've applied this series, and your series "[PATCH 0/2] Fix sleeping function
called from invalid context", and the warnings from dma-debug.c I was
seeing on r8a7791/koelsch are gone.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
