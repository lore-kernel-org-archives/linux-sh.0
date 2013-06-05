From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Jun 2013 07:03:26 +0000
Subject: Re: [PATCH 1/4] irqchip: irqc: Add runtime PM support
Message-Id: <CANqRtoTxxtj-uKyM58dKfH6GV62G8nweQeh9W3+VW==USOkj9A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370406751-3852-1-git-send-email-horms+renesas@verge.net.au>
 <1370406751-3852-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370406751-3852-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon and Morimoto-san,

On Wed, Jun 5, 2013 at 1:32 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> This was tested using the SMSC LAN on the APE6EVM board.
>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/irqchip/irq-renesas-irqc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks for your patch. I am trying to understand how this controls the
actual hardware. Which clock and/or power domain is being controlled
using this patch?

Cheers,

/ magnus
