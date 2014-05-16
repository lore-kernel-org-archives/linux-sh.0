From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 16 May 2014 14:54:52 +0000
Subject: Re: [PATCH v2 1/4] pinctrl: sh-pfc: Don't set the pinmux_irq irq field for multiplatform
Message-Id: <CACRpkdb7HtKJnR_ZbsTkV1yYok=2X1Oe+A0BvQA8emPhimTfiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399981069-29366-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1399981069-29366-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 13, 2014 at 1:37 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> In the multiplatform kernel case the IRQs associated with the PFC GPIOs
> are specified through DT. The pinmux_irq irq field is thus ignored by
> the code, and doesn't need to be set.
>
> This will allow removing the mach/irq.h include from pfc-*.c files that
> was required for the irq_pin() macro used to initialize the irq field.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

OK I've applied Laurent's slim patch set patches 1 thru 4.

Yours,
Linus Walleij
