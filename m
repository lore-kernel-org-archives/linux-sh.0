From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Aug 2012 07:41:28 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <87haryrowr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul
Cc Magnus

> > > place. At least we know the irqdomain code isn't at fault anymore.

I tried show irq number on "non-irqdomain kernel" and "irqdomain kernel".
And compared these 2 kernel irq table.
("irqdomain kernel" doesn't have my quick hack patch => got WARNING)

It were
	register_intc_controller(&intcs_desc);
	register_intc_controller(&intca_irq_pins_desc);
	register_intc_controller(&intc_pint0_desc);
	register_intc_controller(&intc_pint1_desc);

1st register_intc_controller()'s irq were
	irqdomain	: from 448 to 680
        non-irqdomain	: from 448 to 680
2nd register_intc_controller()'s irq were
	irqdomain	: from 560 to 959 <        non-irqdomain	: from 544 to 943 <3rd register_intc_controller()'s irq were
	irqdomain	: from 700 to 731
        non-irqdomain	: from 700 to 731
4th register_intc_controller()'s irq were
	irqdomain	: from 732 to 739
        non-irqdomain	: from 732 to 739

2nd register_intc_controller() mapped irq to strange area.

Best regards
---
Kuninori Morimoto
