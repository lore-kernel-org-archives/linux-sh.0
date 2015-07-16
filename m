From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2015 09:38:55 +0000
Subject: Re: [PATCH v2 2/4] pinctrl: sh-pfc: Remove obsolete sh73a0 platform_device_id entry
Message-Id: <CACRpkdYCFWdSNxW0X91NWKwB4q03ibHzgCx=yE6wtfRqj9XK5g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436875015-13706-1-git-send-email-geert+renesas@glider.be>
	<1436875015-13706-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436875015-13706-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Jul 14, 2015 at 1:56 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since the removal of the sh73a0 legacy SoC code in commit
> 9a9863987bf7307f ("ARM: shmobile: Remove legacy SoC code for SH-Mobile
> AG5"), sh73a0 is only supported in generic DT-only ARM multi-platform
> builds.  The driver doesn't need to match platform devices by name
> anymore, hence remove the corresponding platform_device_id entry.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> The commit mentioned above is in -next, destined for v4.3.

Patch applied.

Yours,
Linus Walleij
