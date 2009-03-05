From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 05 Mar 2009 08:31:09 +0000
Subject: Re: [PATCH v2] Add OHCI USB support for SH7786
Message-Id: <20090305083109.GA16451@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlg2yu02.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlg2yu02.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 04, 2009 at 07:51:12PM +0900, morimoto.kuninori@renesas.com wrote:
> > > + ? ? ? /*
> > > + ? ? ? ?* USB initial settings
> > > + ? ? ? ?*
> > > + ? ? ? ?* The following settings are necessary
> > > + ? ? ? ?* for using the USB modules.
> > > + ? ? ? ?*/
> > > + ? ? ? __raw_writel(0x00ff0040, 0xffe70094);
> > > + ? ? ? __raw_writel(0x00000001, 0xffe7009c);
> > > +
> > You forget to revise here.
> 
> well... there are no name in these register,
> and there are no explanation about these value in manual.
> It just say do so.
> This is the reason why I didn't use MACRO here.
> 
> But should I use MACRO ?
> 
If this setting is needed, it needs to be documented. While getting a set
of register and value pairs from the hardware team is sufficient for
device bring-up, we can not maintain or debug this if we have no idea
what it is doing. Please confirm with the hardware team what this is
necessary for, we especially need to be aware of whether this is an
errata issue or not and whether this will continue to be necessary on
future cuts.
