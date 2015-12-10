From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Dec 2015 23:13:57 +0000
Subject: Re: [PATCH v2 1/2] gpio: rcar: Remove obsolete platform data support
Message-Id: <CACRpkdZDkH_ADYthEOmZZWuyoJTegVTSBSxvCLQ3KB-AJm4U2w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449243233-11089-1-git-send-email-geert+renesas@glider.be>
	<1449243233-11089-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449243233-11089-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Fri, Dec 4, 2015 at 4:33 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
> setup code"), Renesas R-Car SoCs are only supported in generic DT-only
> ARM multi-platform builds.  The driver doesn't need to use platform data
> anymore, hence remove platform data configuration.
>
> Make gpio_rcar_priv.has_both_edge_trigger a boolean for consistency with
> gpio_rcar_info.has_both_edge_trigger.
> Move gpio_rcar_priv.irq_parent down while we're at it, to prevent gaps
> on 64-bit.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Commit 4baadb9e05c68962 is in v4.4-rc1.
>
> v2:
>   - Convert gpio_rcar_priv.has_both_edge_trigger from a bitfield to a
>     boolean.

Patch applied. Thanks for fixing this the way I want it, too.

Yours,
Linus Walleij
