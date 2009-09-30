From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 30 Sep 2009 00:32:14 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: modify MTD mask_flags typo
Message-Id: <uljjx9ss1.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbumqaj9.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbumqaj9.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Jean

Thank you for review

> > This patch modify bug which can erase boot loader image area.
> IIC you do not want to be able to modify the boot loader area
> why?

IIC = I2C ?
I think boot loader area should not be changed (erased) from Linux.
because you might not be able to reboot it.

And now I checked other board settings.
other board use MTD_WRITEABLE to force read only.
So, I will re-send v2 patch soon

Thank you

Best regards
--
Kuninori Morimoto
 
