From: morimoto.kuninori@renesas.com
Date: Thu, 09 Apr 2009 08:36:23 +0000
Subject: Re: [PATCH] sh7786: modify usb setup timeout judgment bug.
Message-Id: <uskkikyuw.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Michael

Thank you for comment

> > 1) Change usb driver to be able to call peculiar init function.
> > 2) setup-sh7786 set peculiar init funtion to usb driver.
> > 3) usb driver call it when start
> >
> > How about this idea ?
> >   
> I think that is a good approch. If it is possible, before the setup, the 
> best thing is to test if the bootloader has just
> enable it and skip the setup part in that case.

wow !!
how cool idea !!

> shimoda san

Can you change use driver to be able to call peculiar init function ?
Or Can I do that ?

Best regards
--
Kuninori Morimoto
 
