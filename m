From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Nov 2013 08:26:47 +0000
Subject: Re: [PATCH 00/03] gpio: R-Car and EM GPIO update
Message-Id: <CACRpkdYZ07wrGiHtFww4TExUM8Ny13OtQZBQ3XqLc-hUC+-5+A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131113225927.21449.78044.sendpatchset@w520>
In-Reply-To: <20131113225927.21449.78044.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Nov 13, 2013 at 11:59 PM, Magnus Damm <magnus.damm@gmail.com> wrote:

> gpio: R-Car and EM GPIO update
>
> [PATCH 01/03] gpio: rcar: Use lazy disable and mask on suspend
> [PATCH 02/03] gpio: em: Setup gpiochip->dev
> [PATCH 03/03] gpio: em: Use lazy disable and mask on suspend
>
> Update the R-Car GPIO driver and the GPIO driver used on EMEV2 to use lazy
> disable and mask on suspend. This fixes the Suspend-to-RAM behavior to make
> sure wakeup sources are left enabled while suspending. Also include a small
> fix for gpio-em that fixes the DT use case.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

These look OK but I see you and Laurent are discussing
patch 1, so whenever you feel ready with the series, please
resend so I can apply it.

Yours,
Linus Walleij
