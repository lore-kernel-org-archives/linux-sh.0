From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jun 2014 23:50:59 +0000
Subject: Re: [PATCH 2/8] shdma: fdt: allocate and use local hwid bitmap for shdma mux
Message-Id: <87sinic3vn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401898455-31064-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1401898455-31064-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Ben

> > This ofs is created by devm_kzalloc(), but not used ??
> > It is missing to call dev_set_platdata() ?
> 
> Thanks for noticing it, I've yet to actually get access to a board
> to test this.

I see.
Thank you for your hard work anyway.
