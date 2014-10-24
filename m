From: Lucas Stach <l.stach@pengutronix.de>
Date: Fri, 24 Oct 2014 10:19:49 +0000
Subject: Re: [RESEND 2] cpufreq: dt: disable unsupported OPPs
Message-Id: <1414145989.6267.3.camel@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <48734362.lRa73hezrZ@vostro.rjw.lan>
	 <1413454100-23009-1-git-send-email-l.stach@pengutronix.de>
	 <8590662.lsNXszcTd0@vostro.rjw.lan>
	 <CAMuHMdV2gPOZoV62rSNjpD=dJ43EE+s0wtRW4ncLWU-J-eHLDg@mail.gmail.com>
	 <1414073448.2764.1.camel@pengutronix.de>
	 <CAMuHMdXAYhAEFNLCcq91xctYwaCZnJt-V+U+vYy1iC5Kb=qqjw@mail.gmail.com>
In-Reply-To: <CAMuHMdXAYhAEFNLCcq91xctYwaCZnJt-V+U+vYy1iC5Kb=qqjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Geert,

Am Donnerstag, den 23.10.2014, 16:43 +0200 schrieb Geert Uytterhoeven:
> Hi Lucas,
>=20
> On Thu, Oct 23, 2014 at 4:10 PM, Lucas Stach <l.stach@pengutronix.de> wro=
te:
> > Am Donnerstag, den 23.10.2014, 11:19 +0200 schrieb Geert Uytterhoeven:
> >> On Tue, Oct 21, 2014 at 4:19 PM, Rafael J. Wysocki <rjw@rjwysocki.net>=
 wrote:
> >> > On Thursday, October 16, 2014 12:08:20 PM Lucas Stach wrote:
> >> >> If the regulator connected to the CPU voltage plane doesn't
> >> >> support an OPP specified voltage with the acceptable tolerance
> >> >> it's better to just disable the OPP instead of constantly
> >> >> failing the voltage scaling later on.
> >> >>
> >> >> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> >
> >> > Applied, thanks!
> >>
> >> This commit
> >> (http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commi=
t/?h=3Dlinux-next&id=D7bbd4cd0359d781b67c9e621d4bbfd1bb2f3783)
> >> causes a boot regression on r8a7791/koelsch. It hangs after:
> >>
> >>     TCP: cubic registered
> >>     Initializing XFRM netlink socket
> >>     NET: Registered protocol family 17
> >>     NET: Registered protocol family 15
> >>     ata1: link resume succeeded after 1 retries
> >>     ata1: SATA link down (SStatus 0 SControl 300)
> >>     random: nonblocking pool is initialized
>=20
> >> Reverting this commit fixes the issue, and makes the boot continue wit=
h:
> >>
> >>     cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq: 130000=
0 KHz
> >>     cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency
> >> changed to: 1312500 KHz
> >>     cpu cpu1: failed to get cpu-2 clock: 1
> >>     cpufreq_dt: cpufreq_init: Failed to allocate resources: -2
> >>
> >

I thought a bit more about about this to make sure this isn't a fault on
my side, but can't seem to make any sense out of this. Can you please
print out the value of opp_freq in each iteration of the while loop and
also the return value of regulator_is_supported_voltage()? This would
help me a lot to understand what's happening here.

Thanks,
Lucas
--=20
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

