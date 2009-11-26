From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 26 Nov 2009 11:08:17 +0000
Subject: Re: [PATCH 1/2] sh: mach-ecovec24: modify memory area calculation
Message-Id: <u638xo866.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <u8wdto9qh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u8wdto9qh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Matt

Thank you for checking patch !!

> I think both of these patches should be using the variable
> "cached_to_uncached", rather than hard coding the value 0x20000000.

I didn't know cached_to_uncached.
But I wonder can I use this variable here (romImage) ?
I think we can use macro here, but can not variable.

How about this ?
----------
 1 :	.long 0xa8000000
-2 :
+2 :	.long P2SEG - P1SEG /* cached_to_uncached */
+3 :
----------


Best regards
--
Kuninori Morimoto
 
