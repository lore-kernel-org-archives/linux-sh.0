From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Feb 2011 01:11:35 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: mackerel: fixup memory initialize
Message-Id: <w3pei77pirc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Simon

> I have verified that this boots on my Mackerel.
> I have also looked over the register changes
> and they seem reasonable to me.
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>

Thanks

> > -ED 0xE6150354, 0x00000002
> > +ED 0xFE400354, 0x01AD8002
> 
> I don't see 0xE6150354 in the processor manual. Was it a typo?

Yes. the original code that I got had typo.

Best regards
--
Kuninori Morimoto
 
