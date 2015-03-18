From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Mar 2015 01:10:15 +0000
Subject: Re: [PATCH v2 1/4] pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned long
Message-Id: <CACRpkdbSNeHcf5H-0ovLYkpoQyPRO2ys_eksKHJhs10x-QVJKQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425985583-26279-1-git-send-email-geert+renesas@glider.be>
	<1425985583-26279-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425985583-26279-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Mar 10, 2015 at 12:06 PM, Geert Uytterhoeven
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
> v2:
>   - Add Acked-by.

Patch applied.

Yours,
Linus Walleij
