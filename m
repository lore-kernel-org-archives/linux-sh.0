From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 20 May 2013 18:08:52 +0000
Subject: Re: [RFC/PATCH 1/2] gpio-rcar: Make the platform data gpio_base field signed
Message-Id: <CACRpkdYZMvWE6HX8K0_Rv6JET0wE=m0MWyuK3ztAgjA34w=-Dw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368197317-13169-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1368197317-13169-2-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1368197317-13169-2-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Magnus Damm <damm@opensource.se>

On Fri, May 10, 2013 at 4:48 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> The gpio_base field is used to specify the desired GPIO base for the
> GPIO controller. The GPIO core can automatically allocate a GPIO number
> range when the base is set to -1. To make this possible, make the field
> signed.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
