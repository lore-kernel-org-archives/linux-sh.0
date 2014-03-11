From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Date: Tue, 11 Mar 2014 12:00:34 +0000
Subject: Re: serial core: crash / race condition on unbind
Message-Id: <20140311120034.632ff833@alan.etchedpixels.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVV_NrQ3PPJwPNx7MoM9TWLdk02d+10zNipNcC7VC0HAA@mail.gmail.com>
	<CAMuHMdVwpQEWAVHA5BO2xXzaNc1DTdteDMWFHQ=MFJoo4Afm_A@mail.gmail.com>
	<531E7F81.20400@hurleysoftware.com>
	<CAMuHMdUeUjuBe0tWpYBZqwqWT=euPAn6fwzmXMYCP573Q1BDXQ@mail.gmail.com>
	<531EF864.5020104@hurleysoftware.com>
In-Reply-To: <531EF864.5020104@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

> > No one unbinds serial drivers using serial_core, as all these drivers are
> > for fixed hardware?
> 
> Yep, never tested until now :)
> Do you need this to work?
> 
> > Hot-pluggable usb-serial doesn't use serial_core.
> 
> I guess none of the 8250 PCI adapters are hot-pluggable...

pcmcia 8250 certainly was and worked - but then I've not had pcmcia ports
in years 8)

