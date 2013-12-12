From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2013 19:54:25 +0000
Subject: Re: [PATCH V2] gpio: rcar: Fix level interrupt handling
Message-Id: <CACRpkdbeT8fp4i-ahpzZN2MnC7uYAcuLH7SOgJnpL54XBaoTqw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385748249-27170-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1385748249-27170-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Fri, Nov 29, 2013 at 7:04 PM, Valentine Barshak
<valentine.barshak@cogentembedded.com> wrote:

> According to the manual, if a port is set for level detection using
> the corresponding bit in the edge/level select register and an external
> level interrupt signal is asserted, the corresponding bit in INTDT
> does not use the FF to hold the input.
> Thus, writing 1 to the corresponding bits in INTCLR cannot clear the
> corresponding bits in the INTDT register. Instead, when an external
> input signal is stopped, the corresponding bit in INTDT is cleared
> automatically.
>
> Since the INTDT bit cannot be cleared for the level interrupts until
> the interrupt signal is stopped, we end up with the infinite loop
> when using deferred (threaded) IRQ handling.
>
> Since a deferred interrupt is disabled by the low-level handler and
> re-enabled only when the deferred handler is completed, Fix the issue
> by dropping disabled interrupts from the pending mask as suggested by
> Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Changes in V2:
> * Drop disabled interrupts from pending mask altogether instead of
>   dropping level interrupts one by one once they get handled.
>
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

This v2 version applied to fixes with Laurent's and Magnus' ACKs,
tell me if it also need to go into -stable.

Yours,
Linus Walleij
