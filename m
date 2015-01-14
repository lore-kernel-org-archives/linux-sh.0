From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Jan 2015 13:13:43 +0000
Subject: Re: [PATCH 1/2] gpio: rcar: Fix error path for devm_kzalloc() failure
Message-Id: <CACRpkdbrz_4cCa4S2aaz0LxsoWvZn1_hPDagC_LH0e=wJ2Bzog@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421057279-16081-1-git-send-email-geert+renesas@glider.be>
	<1421057279-16081-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421057279-16081-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jan 12, 2015 at 11:07 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If the call to devm_kzalloc() fails, nothing must be cleant up.
> This was missed before because gpio_rcar_probe() had a "return"
> statement after the first "goto err0".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: df0c6c80232f2ad4 ("gpio: rcar: Add minimal runtime PM support")

Patch applied.

Yours,
Linus Walleij
