From: takasi-y@ops.dti.ne.jp
Date: Wed, 08 Apr 2009 13:32:16 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <200904081332.n38DWGw6020400@smtp09.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,
> I have question about sh-sci on SH7723.
...
> seems return SCIF0_TXD value.
At least, old chips like 7709/7750 have SCPTR bit multiplexed.
It returns RXD when read, sets TxD when write.
What are SCPTR bits on SH7723 like?
# I think you would better asking your boss to put the HW manual on WWW.
/yoshii
