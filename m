From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Wed, 05 Mar 2014 18:42:19 +0000
Subject: Re: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping when possible
Message-Id: <20140305184219.GA29903@obsidianresearch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Mar 05, 2014 at 02:25:51PM +0100, Lucas Stach wrote:
> -	return pp->irq;
> +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> +	if (!irq)
> +		irq = pp->irq;

In light of the two bugs that Tim found, it might be wise to throw a
'dev_warn(FW_BUG "Missing DT interrupt mapping")' in the fall back
path, so it doesn't continue to silently cover up errors on the OF/DT
side..

Regards,
Jason
