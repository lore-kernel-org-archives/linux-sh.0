From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Mar 2013 14:05:45 +0000
Subject: Re: [PATCH v4 22/29] sh-pfc: Replace pinctrl_add_gpio_range() with gpiochip_add_pin_range()
Message-Id: <CACRpkdZeOfoNj7A4AcNc-VpGvw+LDJ21uWCnM9gwShm8Hm8Uaw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362740170-19073-23-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362740170-19073-23-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 8, 2013 at 11:56 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Adding a GPIO range to a pinctrl device logically belongs to the GPIO
> driver. Switch to the right API.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Excellent!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
