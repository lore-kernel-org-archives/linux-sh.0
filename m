From: morimoto.kuninori@renesas.com
Date: Thu, 09 Apr 2009 04:03:41 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <u3acimq1u.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Iwamatsu

> > But SH7723 doesn't have SCPTR/SCSPTR register.
> > Therefore, I thought that it used IO port.
> > 
> > So, I thought that it should read RXD pin if it use IO port.
(snip)
> I think that this is coding miss.
> If you check implemenation of other SH CPU's(e.g. SH7722),
> you can understand that other CPU checked RXD bit.

If this is a just "coding miss", I can understand !!
Thank you

Best regards
--
Kuninori Morimoto
 
