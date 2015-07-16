From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2015 09:38:02 +0000
Subject: Re: [PATCH v2 1/4] pinctrl: sh-pfc: sh73a0: Remove obsolete multi-platform check
Message-Id: <CACRpkdYWaxPs15SNs=JEimyxwrxQjcY-X2g_scU7XEE35Xce9w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436875015-13706-1-git-send-email-geert+renesas@glider.be>
	<1436875015-13706-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436875015-13706-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Jul 14, 2015 at 1:56 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since the removal of the sh73a0 legacy SoC code in commit
> 9a9863987bf7307f ("ARM: shmobile: Remove legacy SoC code for SH-Mobile
> AG5"), sh73a0 is only supported in generic ARM multi-platform builds.
> Hence CONFIG_ARCH_MULTIPLATFORM is always set, and the check can be
> removed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> The commit mentioned above is in -next, destined for v4.3.

Patch applied.

Yours,
Linus Walleij
