From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 09 Jun 2011 06:42:44 +0000
Subject: Re: Ecovec (SH7724) board doesn't work on latest linus tree
Message-Id: <w3psjrj5wv5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> Grr. Can you try with the following debug patch?
(snip)
> +	printk_once("%s: vaddr %p, CAC %08lx, P1SEG %08lx\n", __func__, vaddr,
> +		CAC_ADDR((unsigned long)vaddr),
> +		P1SEGADDR((unsigned long)vaddr));
> +

It say

dma_cache_sync: vaddr 8e000000, CAC 6e000000, P1SEG 8e000000       

Best regards
--
Kuninori Morimoto
 
