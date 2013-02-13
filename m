From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 04:41:01 +0000
Subject: Re: [PATCH v2 5/8] ARM: shmobile: add sh73a0-specific timer initialisation to kzm9g-reference
Message-Id: <20130213044100.GO30425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-6-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-6-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Feb 13, 2013 at 01:15:59PM +0900, Magnus Damm wrote:
> Hi Simon,
>=20
> On Wed, Feb 13, 2013 at 12:46 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Feb 08, 2013 at 07:38:29PM +0100, Guennadi Liakhovetski wrote:
> >> This patch fixes failing boot of the kzm9g-reference kernel.
> >
> > Magnus specifically asked for the DT reference code not to use
> > early timers.
> >
> > As you have no doubt observed the current code doesn't work with SMP.
> > I have not been able to find a solution that does work with CONFIG_SMP
> > enabled without using early timers. I would welcome some ideas
> > on how to resolve this problem without using early timers.
>=20
> I have now tracked down and submitted a fix for the KZM9D regression
> you pointed me to earlier.
>=20
> Next step is to figure out what is wrong with KZM9G in DT-only mode.
> Can you guide me to reproduce off-list?

I'd prefer to guide you on list so the knowledge is archived.

1. Obtain the reference code.

   I suggest the boards-kzm9g-reference branch of the renesas tree.

2. Configure

   ARCH=3Darm make kzm9g_defconfig

   Also, enable CONFIG_MACH_KZM9G_REFERENCE and CONFIG_ARM_APPENDED_DTB

   N.B: CONFIG_ARM_APPENDED_DTB will be enabled by default in 3.8

3. Compile

4. Append arch/arm/boot/dts/sh73a0-kzm9g-reference.dtb to zImage and
   refresh uImage

4. Boot, you should see the boot halt at:

   ...
   NR_IRQS:16 nr_irqs:16 16
   sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 348966=
0920ms
   Console: colour dummy device 80x30
   console [tty0] enabled
   Calibrating delay loop (skipped) preset value.. 2287.41 BogoMIPS (lpj=89=
36512)
   pid_max: default: 32768 minimum: 301
   Mount-cache hash table entries: 512
   CPU: Testing write buffer coherency: ok
   CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
   Setting up static identity map for 0x4132aaf8 - 0x4132ab50
