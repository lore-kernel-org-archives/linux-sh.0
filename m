From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 21 Jul 2013 15:26:17 +0000
Subject: Re: [PATCH] gpio: em: Add pinctrl support
Message-Id: <CACRpkdYVFVBQmrHUQowOA=KJEM9vwoh_4LxUibBZOrfg8eyXgg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130703041432.7351.45970.sendpatchset@w520>
In-Reply-To: <20130703041432.7351.45970.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@linaro.org>

On Wed, Jul 3, 2013 at 6:14 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> Register the GPIO pin range, and request and free GPIO pins using the
> pinctrl API. The pctl_name platform data member should be used by
> platform devices to point out which pinctrl device to use.
>
> Follows same style as "dc3465a gpio-rcar: Add pinctrl support",
> by Laurent Pinchart, thanks to him.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Patch applied.

As mentioned, Simon anyway will have a ton of deps on the
pinctrl tree so we'll need to stabilize it there and then base
subsequent work on shmobile on it.

(Allow some time before I say that anything on devel is
stable though.)

Yours,
Linus Walleij
