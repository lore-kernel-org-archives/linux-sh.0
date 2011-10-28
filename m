From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 28 Oct 2011 23:16:27 +0000
Subject: Re: [PATCH] regulator: Provide dummy supply support
Message-Id: <CAJaTeTr8mtN1VW=Lf4cgpf_xYRYYtmE6kA11kSe2usL=Hw8dTw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1319833618-25190-1-git-send-email-s.hauer@pengutronix.de>
 <1319833618-25190-2-git-send-email-s.hauer@pengutronix.de>
 <20111028215931.GA30366@opensource.wolfsonmicro.com> <20111028224757.GG23421@pengutronix.de>
In-Reply-To: <20111028224757.GG23421@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, linux-sh@vger.kernel.org, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Sat, Oct 29, 2011 at 00:47, Sascha Hauer wrote:
> On Fri, Oct 28, 2011 at 11:59:31PM +0200, Mark Brown wrote:
>> On Fri, Oct 28, 2011 at 10:26:58PM +0200, Sascha Hauer wrote:
>>
>> > =A0drivers/regulator/Makefile =A0 =A0 =A0 =A0| =A0 =A02 +-
>> > =A0drivers/regulator/dummy-supply.c =A0| =A0 88 ++++++++++++++++++++++=
+++++++++++++++
>>
>> We already have a dummy regulator driver and a fixed voltage regulator
>> driver, we shouldn't be adding a third implementation of the same thing.
>> Just use the fixed voltage regulator for this.
>
> I explained in my mail why I think that the current implementation of
> the dummy regulator is not suitable for things apart from debugging.
>
> My main concern with the fixed regulator is that it needs quite much
> boilerplate code just to say that we have no regulator at all for a
> given device. That could also be handled with a helper function which
> registers a fixed regulator and only takes the regulator_consumer_supply
> as an argument. Would that be ok for you?

i think Mark's point is that we have code in dummy.c already to
provide a dummy regulator.  so your needs sounds like it could be
satisfied with some Kconfig/ifdef massaging and the existing
drivers/regulator/dummy.c rather than introducing a completely
parallel file that is always enabled ?
-mike
