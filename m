From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 06 Mar 2015 10:48:45 +0000
Subject: Re: [PATCH 2/4] pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned long
Message-Id: <CACRpkdbv8V2DY6DniY5fOaSQNkNZtZQ6G_hrm-vcG9cjFTSAEA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
	<1425058685-12956-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425058685-12956-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Fri, Feb 27, 2015 at 6:38 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Register and field widths are in the range 1..32. Storing them in the
> pinctrl data in (arrays of) unsigned long wastes space.
>
> This decreases the size of a (32-bit) shmobile_defconfig kernel
> supporting 7 SoCs by 26460 bytes.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This 2/4 is not ACKed so pausing application after 1/4.

Is 3,4/4 independent of this patch?

Yours,
Linus Walleij
