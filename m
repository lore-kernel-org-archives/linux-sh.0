From: Simon Horman <horms@verge.net.au>
Date: Wed, 19 Jun 2013 12:27:54 +0000
Subject: Re: [PATCH v2] ARM: shmobile: irqpin: add a DT property to enable masking on parent
Message-Id: <20130619122754.GD32292@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306190751090.6945@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306190751090.6945@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree-discuss@lists.ozlabs.org

On Wed, Jun 19, 2013 at 07:53:09AM +0200, Guennadi Liakhovetski wrote:
> To disable spurious interrupts, that get triggered on certain hardware, the
> irqpin driver masks them on the parent interrupt controller. To specify
> such broken devices a .control_parent parameter can be provided in the
> platform data. In the DT case we need a property, to do the same.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Acked-by: Magnus Damm <damm@opensource.se>
> ---
> 
> v2: rebased on top of the current tree, also added Acked-by from Magnus
> 
>  .../interrupt-controller/renesas,intc-irqpin.txt   |    2 ++
>  drivers/irqchip/irq-renesas-intc-irqpin.c          |    7 +++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Thanks, I will queue this up in the dt branch.
