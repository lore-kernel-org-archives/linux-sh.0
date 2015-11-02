From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Nov 2015 07:51:41 +0000
Subject: Re: [PATCH/RFC net-next] ravb: use clock rate as basis for GTI.TIV
Message-Id: <CAMuHMdVQWMc-giQb-J0JV9JXLCYLXHQJhStRgwHZX0qjgye0cw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446428439-10944-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1446428439-10944-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Mon, Nov 2, 2015 at 2:40 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> The motivation for this is to use the correct rate on
> the r8a7795/Slavator-X which is advertised as 133MHz but

Salvator-X

> may differ depending on the extal present on the Slavator-X.

Salvator-X

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
