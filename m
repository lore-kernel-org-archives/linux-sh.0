From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Oct 2015 10:20:21 +0000
Subject: Re: [PATCH/RFC 0/4] pinctrl: sh-pfc: Add PINMUX_SINGLE()
Message-Id: <CACRpkdYdV6iKL0Jnbzz=5JPkMmGS-0yfT+8Hp1mYtUS32xifhg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Oct 20, 2015 at 9:26 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

>         Hi,
>
> Currently single-function pins are described using the raw PINMUX_DATA()
> macro.
>
> Morimoto-san doesn't like that. He proposed to use the existing
> PINMUX_IPSR_NOGP() macro instead (cfr. "[RFC] pinctrl: sh-pfc: r8a7795:
> Add pinmux data for single-function pins",
> http://www.spinics.net/lists/linux-sh/msg44823.html).
> However, that macro is intended to describe a pinmux configuration
> without GPIO function, which feels wrong to me.
>
> This patch series proposes an alternative, introducing a new macro
> PINMUX_SINGLE() to describe a pinmux configuration for a single-function
> pin. It also converts the existing single-function pin descriptions.

If Laurent gives his ACK you can stack these patches for your
next pull request.

Yours,
Linus Walleij
