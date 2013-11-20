From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Nov 2013 13:41:11 +0000
Subject: Re: [PATCH 05/05 v2] gpio: em: Enable mask on suspend
Message-Id: <CACRpkdZX=_9dp4DRHhDXTF+fyTH17iyYnGezbeHD3vBUXbNBww@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120002259.27342.35575.sendpatchset@w520>
	<20131120002344.27342.23018.sendpatchset@w520>
In-Reply-To: <20131120002344.27342.23018.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Nov 20, 2013 at 1:23 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> Now when lazy interrupt disable has been enabled in the driver
> then extend the code to set IRQCHIP_MASK_ON_SUSPEND which tells
> the core that only IRQs marked as wakeups need to stay enabled
> during Suspend-to-RAM.
>
> Tested on the KZM9D board with GPIO-keys.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Patch applied.

Yours,
Linus Walleij
