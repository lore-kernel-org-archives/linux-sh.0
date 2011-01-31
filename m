From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 31 Jan 2011 06:28:26 +0000
Subject: Re: sh-2.6 v2.6.37 and rsk+7203 framebuffer management
Message-Id: <201101310728.27141.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101310645.09489.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101310645.09489.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi guys,
I have given a look at the hm of sh4 7760 and sh2a 7203.
It seems that the LCDC is the same, lass the addresses of the register.
I suppose I derive the driver from sh7760fb.c / sh7760fb.h

But, do I have to assume tha it is not possible to use as is the 
sh_mobile_lcdc modules?

Thanks a lot


On Monday 31 January 2011 06:45:09 Fabio Giovagnini wrote:
> Hi all,
> first of all thanks a lot for your support.
> Now I'm synchronized with the last kernel v2.6.37 and I can boot the
> system. In this thee under drivers/video the is no more the sh7203fc.c
> driver. Two questions:
> 1) is it possible to use as is teh sh_mobile_lcdc driver as is?
> 2) If 1) not; which one existing is it better to get for starting thr
> workaround?
> 
> Thanks

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
