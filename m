From: Chris Ball <cjb@laptop.org>
Date: Tue, 10 Jul 2012 04:04:27 +0000
Subject: Re: Boot regression on Mackerel with current mainline
Message-Id: <87ipdws1mc.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201207031218.24797.rjw@sisk.pl>
	<Pine.LNX.4.64.1207031336320.29890@axis700.grange>
	<201207031910.24864.rjw@sisk.pl>
	<Pine.LNX.4.64.1207041125330.21042@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207041125330.21042@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 4 Jul 2012 11:39:07 +0200 (CEST)")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Thomas Gleixner <tglx@linutronix.de>

Hi Guennadi,

On Wed, Jul 04 2012, Guennadi Liakhovetski wrote:
> On Tue, 3 Jul 2012, Rafael J. Wysocki wrote:
>
>> On Tuesday, July 03, 2012, Guennadi Liakhovetski wrote:
>> > Hi Rafael
>> >=20
>> > On Tue, 3 Jul 2012, Rafael J. Wysocki wrote:
>> >=20
>> > > Hi,
>> > >=20
>> > > We seem to have a functional regression on Mackerel with 3.5-rc5 whi=
ch
>> > > seems to be related to SDHI.  Namely, the SDHI driver appears to wai=
t forever
>> > > for the devices to appear and commenting out all of the sdhi devices=
 in the
>> > > board file works around the problem.
>> > >=20
>> > > I can investigate some more later today if need be.
>> >=20
>> > Have you checked the logs? Are you seeing any of these in the kernel l=
og:
>> >=20
>> > genirq: Threaded irq requested with handler=3DNULL and !ONESHOT for ir=
q=20
>>=20
>> I see this only once per boot, but then sh_mobile_sdhi is saying "timeout
>> waiting for hardware interrupt" pretty much continuously.
>
> Yes, that's the one. Ok, let's fix it in the driver. In fact, a fix has=20
> already been submitted, but for 3.6. I hoped, 3.5 would resort to a softe=
r=20
> form of the ONESHOT failing, so, I didn't push it for -rc. I think, the=20
> easiest would be to apply these two patches:
>
> "mmc: tmio: use MMC opcode defines instead of numbers"
> http://git.kernel.org/?p=3Dlinux/kernel/git/cjb/mmc.git;a=3Dcommit;hY8cd9=
cc217b0aa46089a3838a8b1c37b97aa08b
>
> and
>
> "mmc: extend and rename cd-gpio helpers to handle more slot GPIO function=
s"
> http://git.kernel.org/?p=3Dlinux/kernel/git/cjb/mmc.git;a=3Dcommit;h=D8e6=
0fb51effc83e6f53de191a8440f46e5a3f2c
>
> The latter one looks big because of a rename, but with "-M" it's pretty=20
> trivial. Chris, do you agree?

Is the minimal fix to just add "| IRQF_ONESHOT" to the request_threaded_irq
argument?  If so, I'd rather push just that for 3.5, and I can take care of
having that change appear simultaneously in linux-next so that there aren't
any conflicts.  Is that okay with you?

Thanks,

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
