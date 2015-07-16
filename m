From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2015 09:39:46 +0000
Subject: Re: [PATCH v2 3/4] pinctrl: sh-pfc: r8a7740: Remove obsolete multi-platform check
Message-Id: <CACRpkdYVG05xPub3fgphf-J_Q1V-LO9MVuT2v0Bzh1oVmvi7uw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436875015-13706-1-git-send-email-geert+renesas@glider.be>
	<1436875015-13706-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436875015-13706-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Jul 14, 2015 at 1:56 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since the removal of the r8a7740 legacy SoC code in commit
> 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code for R-Mobile
> A1"), r8a7740 is only supported in generic ARM multi-platform builds.
> Hence CONFIG_ARCH_MULTIPLATFORM is always set, and the check can be
> removed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> The commit mentioned above is in -next, destined for v4.3. Please apply.

Patch applied.

Yours,
Linus Walleij
