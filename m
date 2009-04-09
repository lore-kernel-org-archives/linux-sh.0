From: morimoto.kuninori@renesas.com
Date: Thu, 09 Apr 2009 02:03:53 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <u7i1umvli.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear yoshii

Thank you for comment

> > I have question about sh-sci on SH7723.
> ...
> > seems return SCIF0_TXD value.
> At least, old chips like 7709/7750 have SCPTR bit multiplexed.
> It returns RXD when read, sets TxD when write.

Hmm.
At least 7786/7785/7763 have SCSPTR register.
It indicates RXD/TXD for me.

May be it is same as  7709/7750's SCPTR.
(I don't have these manual)

> What are SCPTR bits on SH7723 like?

But SH7723 doesn't have SCPTR/SCSPTR register.
Therefore, I thought that it used IO port.

So, I thought that it should read RXD pin if it use IO port.

> # I think you would better asking your boss to put the HW manual on WWW.

Oops !
Is SH7723's manual un-public one ?

Best regards
--
Kuninori Morimoto
 
