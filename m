From: Simon Horman <horms@verge.net.au>
Date: Tue, 28 Apr 2015 02:08:25 +0000
Subject: Re: [PATCH v2] irqchip: renesas-intc-irqpin: Improve binding documentation
Message-Id: <20150428020825.GC26051@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430145937-29267-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430145937-29267-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 27, 2015 at 04:45:37PM +0200, Geert Uytterhoeven wrote:
> Add missing documentation for required properties:
>   - interrupt-controller,
>   - parent interrupts (one entry per provided interrupt).
> 
> Add missing documentation for optional properties:
>   - functional clock (managed since commit 705bc96c2c15313c ("irqchip:
>     renesas-intc-irqpin: Add minimal runtime PM support")),
>   - power-domains.
> 
> Add an example, taken from r8a7740.dtsi.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
