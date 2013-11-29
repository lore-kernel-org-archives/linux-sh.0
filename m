From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Nov 2013 20:17:39 +0000
Subject: Re: [PATCH] gpio: rcar: Add r8a7791 support to the DT bindings
Message-Id: <CACRpkdb5u46DVjfw_90Abpo06d_qRwMGUhhvx4HHUjG86WNOpA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385756097-6627-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385756097-6627-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Nov 29, 2013 at 9:14 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The r8a7791 (R-Car M2) has a GPIO controller with additional features
> compared to the generic renesas,gpio-rcar compatible devices. Add a
> model-specific string to let the driver enable these features.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

OK nothing controversial, patch applied.

Yours,
Linus Walleij
