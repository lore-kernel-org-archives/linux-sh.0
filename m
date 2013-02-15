From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 15 Feb 2013 19:37:03 +0000
Subject: Re: [PATCH 1/9] sh-pfc: Add OF support
Message-Id: <CACRpkdYetPi=-wz+ESkJz_2LmfgDttUytwa8CAQNWu101aVtbA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
 <1360726161-16072-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360726161-16072-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 13, 2013 at 4:29 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Support device instantiation through the device tree. The compatible
> property is used to select the SoC pinmux information.
>
> Set the gpio_chip device field to the PFC device to enable automatic
> GPIO OF support.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
