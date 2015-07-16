From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2015 09:40:29 +0000
Subject: Re: [PATCH v2 4/4] pinctrl: sh-pfc: Remove obsolete r8a7740 platform_device_id entry
Message-Id: <CACRpkdacAZQ-i6-UX=n673Qu4=MPw+EeSSePOjHCtYygjoFWug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436875015-13706-1-git-send-email-geert+renesas@glider.be>
	<1436875015-13706-5-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436875015-13706-5-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Jul 14, 2015 at 1:56 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since the removal of the r8a7740 legacy SoC code in commit
> 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code for R-Mobile
> A1"), r8a7740 is only supported in generic DT-only ARM multi-platform
> builds.  The driver doesn't need to match platform devices by name
> anymore, hence remove the corresponding platform_device_id entry.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> The commit mentioned above is in -next, destined for v4.3. Please apply.

Patch applied.

Yours,
Linus Walleij
