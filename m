From: Jason Cooper <jason@lakedaemon.net>
Date: Sun, 14 Sep 2014 05:32:41 +0000
Subject: Re: [PATCH v2 1/3] irqchip: renesas-intc-irqpin: Document SoC-specific bindings
Message-Id: <20140914053241.GH21986@titan.lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1409212800-4957-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409212800-4957-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Aug 28, 2014 at 09:59:58AM +0200, Geert Uytterhoeven wrote:
> The documentation only mentioned the generic fallback compatible property.
> Add the missing SoC-specific compatible properties, which are already in
> use.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v2:
>   - Add Acked-by
> ---
>  .../bindings/interrupt-controller/renesas,intc-irqpin.txt         | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Whole series applied to irqchip/core

thx,

Jason.
