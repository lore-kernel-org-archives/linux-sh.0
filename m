From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 07 Dec 2012 08:16:54 +0000
Subject: Re: [PATCH] gpio: pcf857x: use client->irq for gpio_to_irq()
Message-Id: <CACRpkdbtAN5A5M7UyuvcmGNVSttzx00B0dW7ejsMvpCdTTww0w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20121203222248.298b3671@frequentis.com>
	<87y5hd80ep.wl%kuninori.morimoto.gx@renesas.com>
	<EA116A090B102B4EBF532A9EECFA1EC5795252C6@vie196nt>
	<87obi86kpp.wl%kuninori.morimoto.gx@renesas.com>
	<EA116A090B102B4EBF532A9EECFA1EC579525758@vie196nt>
	<87lidb7dhb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lidb7dhb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, ENGELMAYER Christian <Christian.Engelmayer@frequentis.com>, linux-kernel@vger.kernel.org

On Thu, Dec 6, 2012 at 10:10 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:

> 6e20a0a429bd4dc07d6de16d9c247270e04e4aa0
> (gpio: pcf857x: enable gpio_to_irq() support)
> added gpio_to_irq() support on pcf857x driver,
> but it used pdata->irq.
> This patch modifies driver to use client->irq instead of it.
> It modifies kzm9g board platform settings,
> and device probe information too.
> This patch is tested on kzm9g board
>
> Reported-by: ENGELMAYER Christian Christian.Engelmayer@frequentis.com
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Patch applied with Simon's ACK, thanks!

Yours,
Linus Walleij
