From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Mon, 11 May 2015 14:10:55 +0000
Subject: Re: [RFC PATCH 1/7] mmc: tmio: Add UHS-I mode support
Message-Id: <1431353455.4222.109.camel@xylophone.i.decadent.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397051.5802.40.camel@xylophone.i.decadent.org.uk>
	 <87egmn4wfo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egmn4wfo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@lists.codethink.co.uk

On Mon, 2015-05-11 at 03:38 +0000, Kuninori Morimoto wrote:
> Hi Ben
> 
> Thank you for your patch
> 
> > Based on work by Shinobu Uehara and Ben Dooks.  This adds the
> > voltage switch operation needed for all UHS-I modes, but not
> > the tuning needed for SDR-104 which will come later.
> > 
> > XXX The card_busy implementation is a bit of a guess.
> > 
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> 
> If original patch was created by Shinobu/Ben Dooks,
> and you updated it, I prefer to add these guys on Signed-off-by line.
[...]

It's not correct to keep someone else's Signed-off-by when making
substantial changes.

Ben.


