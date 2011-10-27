From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Oct 2011 22:43:35 +0000
Subject: Re: [PATCH 2/2 v3] net/smsc911x: Add regulator support
Message-Id: <CAJaTeTpPxmFKa4D-NOXvuoL52esaouT-tkCupZm86nR1ZFVfxA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1319719691-15799-1-git-send-email-linus.walleij@stericsson.com>
 <CAJaTeTrzFwxsn22U-NHQ8iCiaUM+mj8PyicavR-DN0HgE08ZEQ@mail.gmail.com>
 <20111027154638.GA16946@sirena.org.uk> <CAJaTeTpzFOdgqGH3vDWY8Mdx7zra8R9nUQYHgsEBfy_yGkEWOw@mail.gmail.com>
 <20111027214241.GA11534@opensource.wolfsonmicro.com>
In-Reply-To: <20111027214241.GA11534@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, netdev@vger.kernel.org, Steve Glendinning <steve.glendinning@smsc.com>, Mathieu Poirer <mathieu.poirier@linaro.org>, Robert Marklund <robert.marklund@stericsson.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Linus Walleij <linus.walleij@linaro.org>

On Thu, Oct 27, 2011 at 23:42, Mark Brown wrote:
> On Thu, Oct 27, 2011 at 10:59:14PM +0200, Mike Frysinger wrote:
>> i saw that !CONFIG_REGULATOR works great. =A0my concern is that these
>> boards don't define any regulators for smsc resources, so if
>> CONFIG_REGULATOR is enabled to test out unrelated daughter cards, i
>> don't want the network driver suddenly failing. =A0Linus' comments
>> suggest that this is what would happen unless each board file has its
>> smsc platform resources extended. =A0maybe i misunderstood what he was s=
aying ?
>
> That's the case that's handled by CONFIG_REGULATOR_DUMMY - if the lookup
> fails the core will provide a virtual regulator to the consumer. =A0If
> you're running a setup like that you probably want to enable dummy
> regulators anyway.

ok, if people configuring need only select that Kconfig symbol to make
it work, i'm fine with things.  thanks for the explanation.
-mike
