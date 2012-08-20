From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Aug 2012 08:35:10 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <87ehn2rmf9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> > 1st register_intc_controller()'s irq were
> > 	irqdomain	: from 448 to 680
> >         non-irqdomain	: from 448 to 680
> > 2nd register_intc_controller()'s irq were
> > 	irqdomain	: from 560 to 959 <> >         non-irqdomain	: from 544 to 943 <> 
> How are you getting these ranges?

Grr. I'm so sorry.
It was my fault.
Above 2nd irqdomain kernel had my quick hack patch.
I double checked irq ranges, and both kernel had same ranges.

I'm so sorry again

Best regards
---
Kuninori Morimoto
