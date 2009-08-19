From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 19 Aug 2009 14:44:20 +0000
Subject: Re: [PATCH 1/3] Add SuperH FSI driver support for ALSA
Message-Id: <20090819144420.GA3323@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
	<aec7e5c30908190659n4b81272ek6e06f23f4ee71a15@mail.gmail.com>
In-Reply-To: <aec7e5c30908190659n4b81272ek6e06f23f4ee71a15@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Wed, Aug 19, 2009 at 10:59:56PM +0900, Magnus Damm wrote:

> > +struct fsi_master *master;

> Is it really necessary to have "master" as a global variable? Maybe
> this global variable is there to work around some framework issue?

There's no ASoC reason for doing this.  Anything that needs to be shared
between different DAIs can always be shared via the DMA driver.

Looking at the driver I rather suspect it only supports one FSI at once
and the capture support is also incomplete.  I don't see much problem
merging the driver with these limitations, it's generally been much
easier to get people to fix problems with merged drivers than to get
people to contribute entirely new drivers.
