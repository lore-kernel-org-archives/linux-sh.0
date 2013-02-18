From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Feb 2013 06:51:51 +0000
Subject: Re: [PATCH v2 5/8] ARM: shmobile: add sh73a0-specific timer initialisation to kzm9g-reference
Message-Id: <20130218065148.GA1377@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-6-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-6-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Feb 18, 2013 at 02:44:40PM +0900, Magnus Damm wrote:
> H Simon,
>=20
> On Wed, Feb 13, 2013 at 11:22 PM, Magnus Damm <magnus.damm@gmail.com> wro=
te:
> > On Wed, Feb 13, 2013 at 2:37 PM, Simon Horman <horms@verge.net.au> wrot=
e:
> >> On Wed, Feb 13, 2013 at 02:04:43PM +0900, Magnus Damm wrote:
> >>> Hi Simon,
> >>>
> >>> On Wed, Feb 13, 2013 at 1:41 PM, Simon Horman <horms@verge.net.au> wr=
ote:
> >>> > On Wed, Feb 13, 2013 at 01:15:59PM +0900, Magnus Damm wrote:
> >>> >> Hi Simon,
> >>> >>
> >>> >> On Wed, Feb 13, 2013 at 12:46 PM, Simon Horman <horms@verge.net.au=
> wrote:
> >>> >> > On Fri, Feb 08, 2013 at 07:38:29PM +0100, Guennadi Liakhovetski =
wrote:
> >>> >> >> This patch fixes failing boot of the kzm9g-reference kernel.
> >>> >> >
> >>> >> > Magnus specifically asked for the DT reference code not to use
> >>> >> > early timers.
> >>> >> >
> >>> >> > As you have no doubt observed the current code doesn't work with=
 SMP.
> >>> >> > I have not been able to find a solution that does work with CONF=
IG_SMP
> >>> >> > enabled without using early timers. I would welcome some ideas
> >>> >> > on how to resolve this problem without using early timers.
> >>> >>
> >>> >> I have now tracked down and submitted a fix for the KZM9D regressi=
on
> >>> >> you pointed me to earlier.
> >>> >>
> >>> >> Next step is to figure out what is wrong with KZM9G in DT-only mod=
e.
> >>> >> Can you guide me to reproduce off-list?
> >>> >
> >>> > I'd prefer to guide you on list so the knowledge is archived.
> >>>
> >>> Ok, thanks, that's fine too of course.
> >>>
> >>> > 1. Obtain the reference code.
> >>> >
> >>> >    I suggest the boards-kzm9g-reference branch of the renesas tree.
> >>> >
> >>> > 2. Configure
> >>> >
> >>> >    ARCH=3Darm make kzm9g_defconfig
> >>> >
> >>> >    Also, enable CONFIG_MACH_KZM9G_REFERENCE and CONFIG_ARM_APPENDED=
_DTB
> >>> >
> >>> >    N.B: CONFIG_ARM_APPENDED_DTB will be enabled by default in 3.8
> >>> >
> >>> > 3. Compile
> >>> >
> >>> > 4. Append arch/arm/boot/dts/sh73a0-kzm9g-reference.dtb to zImage and
> >>> >    refresh uImage
> >>> >
> >>> > 4. Boot, you should see the boot halt at:
> >>> >
> >>> >    ...
> >>> >    NR_IRQS:16 nr_irqs:16 16
> >>> >    sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps ever=
y 3489660920ms
> >>> >    Console: colour dummy device 80x30
> >>> >    console [tty0] enabled
> >>> >    Calibrating delay loop (skipped) preset value.. 2287.41 BogoMIPS=
 (lpj=8936512)
> >>> >    pid_max: default: 32768 minimum: 301
> >>> >    Mount-cache hash table entries: 512
> >>> >    CPU: Testing write buffer coherency: ok
> >>> >    CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> >>> >    Setting up static identity map for 0x4132aaf8 - 0x4132ab50
> >>>
> >>> I assume someone has already tested the obvious things like booting
> >>> with maxcpus=3D1 and checking if disabling TWD helps.
> >>
> >> Yes.
> >
> > Good.
> >
> > So now I have cooked up a DT SMP reference implementation. Please have
> > a look at the series "[PATCH 00/02] ARM: shmobile: EMEV2 SMP DT
> > reference code (hack alert!)". With those patches in place the KZM9D
> > runs SMP via DT from setup-emev2.c only - using shmobile_timer_init.
> > Have a look at the rather limited build instructions in [PATCH 00/02]
> > - nothing fancy is needed. I believe you can boot with and without the
> > STI timer.
> >
> > So now we know that we have a rather simple KZM9D DT implementation
> > using SMP with shmobile_timer_init. It must be possible to do the same
> > on sh73a0, simply start building from the ground up with SCIF-only to
> > begin with. First get SCIF-only going with UP then move over to
> > SCIF-only with SMP.
>=20
> I see that you recently posted some patches related to SMP on sh73a0 DT.
>=20
> Can you please explain to the list what you had to to - so the
> knowledge is archived?

I will explain on-list. Basically the code was working but
only if CONFIG_PREEMPT was not selected. The fix is not to select it.
IIRC, the other changes are just clean up.
