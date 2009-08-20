From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Aug 2009 12:11:10 +0000
Subject: Re: [PATCH 1/3] Add SuperH FSI driver support for ALSA
Message-Id: <aec7e5c30908200511i676cc2a0wb85cf65b18259708@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
	 <aec7e5c30908190659n4b81272ek6e06f23f4ee71a15@mail.gmail.com>
	 <20090819144420.GA3323@rakim.wolfsonmicro.main>
In-Reply-To: <20090819144420.GA3323@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, lethal@linux-sh.org, Takashi Iwai <tiwai@suse.de>

On Wed, Aug 19, 2009 at 11:44 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Aug 19, 2009 at 10:59:56PM +0900, Magnus Damm wrote:
>
>> > +struct fsi_master *master;
>
>> Is it really necessary to have "master" as a global variable? Maybe
>> this global variable is there to work around some framework issue?
>
> There's no ASoC reason for doing this. =A0Anything that needs to be shared
> between different DAIs can always be shared via the DMA driver.

I sometimes see i2c workarounds so i was wondering if this was a
similar issue. Good to hear that the ASoC framework is clean.

> Looking at the driver I rather suspect it only supports one FSI at once
> and the capture support is also incomplete. =A0I don't see much problem
> merging the driver with these limitations, it's generally been much
> easier to get people to fix problems with merged drivers than to get
> people to contribute entirely new drivers.

Doing it incrementally sounds very good. Thank you!

/ magnus
