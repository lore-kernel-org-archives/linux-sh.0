From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Nov 2013 13:37:22 +0000
Subject: Re: [PATCH 02/05 v2] gpio: rcar: Enable mask on suspend
Message-Id: <CACRpkdYQB0eMHhE-Y1mgnaeoyLOJxLEdzbeo9eh=tmhNn6XkKg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120002259.27342.35575.sendpatchset@w520>
	<20131120002317.27342.34257.sendpatchset@w520>
In-Reply-To: <20131120002317.27342.34257.sendpatchset@w520>
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
> Tested on the Lager board with GPIO-keys and Suspend-to-RAM.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Patch applied.

Yours,
Linus Walleij
