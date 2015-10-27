From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Oct 2015 10:18:33 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: Improve pinmux macros documentation
Message-Id: <CACRpkdYDZ9SZ8qTx4Ly3QtnKfwkxJc-yRHPeWaGjVE0Nqpy12Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445368482-24278-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445368482-24278-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niso@kth.se>, Koji Matsuoka <koji.matsuoka.xm@rms.renesas.com>, Magnus Damm <damm@opensource.se>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Oct 20, 2015 at 9:14 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Fix some s/ispr/ipsr/ typos in macro parameters while we're at it.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Clarify same width vs. different widths,
>   - Mention GPSR for PINMUX_IPSR_DATA(),
>   - Document NOGM (= NOGP + MSEL),
>   - Fix s/ispr/ipsr/ typos.

Acked-by, I guess you're continuing to collect patches. This one
could use Lauren'ts ACK.

Yours,
Linus Walleij
