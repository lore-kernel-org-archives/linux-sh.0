From: Simon Horman <horms@verge.net.au>
Date: Wed, 26 Aug 2015 00:36:43 +0000
Subject: Re: [PATCH] gpio: rcar: GPIO_RCAR doesn't relate to ARM
Message-Id: <20150826003643.GC11168@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871ter7n17.wl%kuninori.morimoto.gx@renesas.com>
 <CAMuHMdXxg+YPHxPdPobNS1C4+khOx6-Ve3nU2UqddTdtdUsCEg@mail.gmail.com>
In-Reply-To: <CAMuHMdXxg+YPHxPdPobNS1C4+khOx6-Ve3nU2UqddTdtdUsCEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Aug 25, 2015 at 11:15:18AM +0200, Geert Uytterhoeven wrote:
> On Tue, Aug 25, 2015 at 11:12 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > 8cd1470("gpio: rcar: Add r8a7795 (R-Car H3) support") added
> > GPIO support for r8a7795. r8a7795 based on CONFIG_ARM64.
> > OTOH, GPIO_RCAR driver can be compiled fine on non-ARM.
> > This patch removed ARM dependency for it.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

