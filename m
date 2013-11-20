From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Nov 2013 13:38:18 +0000
Subject: Re: [PATCH 03/05] gpio: em: Setup gpiochip->dev
Message-Id: <CACRpkdayj-4w-X0YQYZP_-Mib18bB7Tc-U+xwD9-09KwVdZdbg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120002259.27342.35575.sendpatchset@w520>
	<20131120002326.27342.83787.sendpatchset@w520>
In-Reply-To: <20131120002326.27342.83787.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Nov 20, 2013 at 1:23 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> Make sure gpio_chip->dev is setup so of_gpiochip_add()
> will work as expected.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Patch applied.

Yours,
Linus Walleij
