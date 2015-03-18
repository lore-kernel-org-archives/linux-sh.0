From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Mar 2015 01:13:17 +0000
Subject: Re: [PATCH v3 1/4] pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned long
Message-Id: <CACRpkdYQa=d=T1WFqsWbLQYHKdYWcbRgouzqTVU5zSgC-TB8CA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426154956-26583-1-git-send-email-geert+renesas@glider.be>
	<1426154956-26583-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426154956-26583-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Mar 12, 2015 at 11:09 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Register and field widths are in the range 1..32. Storing them in the
> pinctrl data in (arrays of) unsigned long wastes space.
>
> This decreases the size of a (32-bit) shmobile_defconfig kernel
> supporting 7 SoCs by 26460 bytes.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v3:
>   - No changes,

Patch applied.

Yours,
Linus Walleij
