From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Oct 2010 10:20:33 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock
Message-Id: <w3pocaxjcsu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> Yes, I noticed after I sent it. You can fix this by changing it to:
> 
> 	if (mapping->base)
> 		kref_get(..)
> 
> Or I can send you an updated path if you prefer.

Thank you I understand.
I can modify it by myself.

Best regards
--
Kuninori Morimoto
 
