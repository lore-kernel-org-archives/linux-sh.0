From: Lucas Stach <l.stach@pengutronix.de>
Date: Thu, 23 Oct 2014 15:13:02 +0000
Subject: Re: [RESEND 2] cpufreq: dt: disable unsupported OPPs
Message-Id: <1414077182.2764.3.camel@pengutronix.de>
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
> > Urgh, thanks for the report. Am I right that for koelsch you do
> > reference a regulator supply for the cpu, but don't actually have a
> > driver for it, so a dummy regulator gets plugged in there?
>=20
> arch/arm/boot/dts/r8a7791-koelsch.dts has:
>=20
> &cpu0 {
>         cpu0-supply =3D <&vdd_dvfs>;
> };
>=20
> &i2c6 {
>         status =3D "okay";
>         clock-frequency =3D <100000>;
>=20
>         vdd_dvfs: regulator@68 {
>                 compatible =3D "dlg,da9210";
>                 reg =3D <0x68>;
>=20
>                 regulator-min-microvolt =3D <1000000>;
>                 regulator-max-microvolt =3D <1000000>;
>                 regulator-boot-on;
>                 regulator-always-on;
>         };
> };
>=20
> CONFIG_REGULATOR_DA9210=3Dy
>=20
> and the driver does seem to run:
>=20
>     DA9210: 1000 mV at 4600 mA
>=20
Ah right, I misread your initial report. So the issue doesn't seem to be
directly related to the cpufreq-dt driver but seems to be located
somewhere deeper down the chain. The fact that this change triggers the
bug may be a hint here. The only thing which is new in the change is
that it tries to get the supported voltage from the regulator. As the
regulator can not change its voltage (min_uV =3D max_uV) this translates
directly to a get_voltage() which in turn only tries to read a register
of the i2c chip via regmap.

So it seems that somehow the i2c transaction fails and things spin
indefinitely there. Maybe this gives a clue on how to debug this
further.

Regards,
Lucas
--=20
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

