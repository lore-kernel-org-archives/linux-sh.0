From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 07:39:42 +0000
Subject: Re: [RFC][PATCH 5/6 v2] ARM: mach-shmobile: sh7372: Add USB-DMAC
Message-Id: <w3paadgq535.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pei2towhu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pei2towhu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Guennadi

> > +/* USB DMAC0 */
> > +static const struct sh_dmae_slave_config sh7372_usb_dmae0_slaves[] = {
> > +	{
> > +		.slave_id	= SHDMA_SLAVE_USB0_TX,
> > +		.chcr		= USBTS_INDEX2VAL(XMIT_SZ_8BYTE),
> > +	}, {
> > +		.slave_id	= SHDMA_SLAVE_USB0_RX,
> > +		.chcr		= TS_INDEX2VAL(XMIT_SZ_8BYTE),
> 
> Is "TS_INDEX2VAL" really correct here or should it be "USBTS_INDEX2VAL"?

Ohh my.. indeed.
Thanks

I send v2 patch

Best regards
--
Kuninori Morimoto
 
