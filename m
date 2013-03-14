From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Mar 2013 14:10:22 +0000
Subject: Re: [PATCH 23/25] sh-pfc: Clean up pin configuration type handling
Message-Id: <CACRpkdaxfD6S+kUbsG66=y4TjqTMqN72tmwOocaMPL=4Yb0sYg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363214384-3870-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363214384-3870-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 13, 2013 at 11:39 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Set pin configuration type to
>
> - PINMUX_TYPE_NONE at initialization time and when disabling a function
>   or freeing a GPIO
>
> - PINMUX_TYPE_FUNCTION when enabling a function
>
> - PINMUX_TYPE_INPUT or PINMUX_TYPE_OUTPUT when setting the GPIO
>   direction
>
> Verify that the type is PINMUX_TYPE_NONE when enabling a function or
> requesting a GPIO and return -EBUSY if it isn't.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
