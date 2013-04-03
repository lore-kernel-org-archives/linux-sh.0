From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 03 Apr 2013 12:35:27 +0000
Subject: Re: [PATCH 2/2] ARM: remove mach .init_irq for irqchip_init users
Message-Id: <CACRpkdapQB7=fem1x8v5nAzitAVMZAe=P4Eroz-wmmK1CQSMgg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1364503606-10597-1-git-send-email-maxime.ripard@free-electrons.com>
 <1364503606-10597-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1364503606-10597-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 28, 2013 at 9:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Now that the arm core code calls irqchip_init, we can remove it from all
> the machines that were using it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

For Nomadik.

Yours,
Linus Walleij
