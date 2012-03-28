From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Mar 2012 07:05:48 +0000
Subject: Re: [PATCH 06/06] ARM: mach-shmobile: Rework sh7372 INTCS demuxer
Message-Id: <20120328070548.GV26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328064105.28557.57736.sendpatchset@w520>
In-Reply-To: <20120328064105.28557.57736.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 28, 2012 at 03:41:05PM +0900, Magnus Damm wrote:
> @@ -554,12 +548,24 @@ static void intcs_demux(unsigned int irq
>  	generic_handle_irq(intcs_evt2irq(evtcodeas));
>  }
>  
> +static void intcs_nop(struct irq_data *data)
> +{
> +}
> +
> +static struct irq_chip intcs_cascade_chip = {
> +	.name		= "INTCS-cascade",
> +	.irq_mask	= intcs_nop,
> +	.irq_unmask	= intcs_nop,
> +	.irq_eoi	= intcs_nop,
> +};
> +

There's no need for this, see kernel/irq/dummychip.c. You can just use
dummy_irq_chip directly, as we already do for the multi-evt cascade case.
