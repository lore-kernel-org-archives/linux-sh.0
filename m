From: Nicolas Pitre <nico@fluxnic.net>
Date: Wed, 02 Jul 2014 03:17:22 +0000
Subject: Re: [PATCH] ARM: convert all "mov.* pc, reg" to "bx reg" for ARMv6+ (part1)
Message-Id: <alpine.LFD.2.11.1407012314100.16842@knanqh.ubzr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary_(ID_mgw8uSma0Mmji5Peh3Zp8w)"
List-Id: <linux-sh.vger.kernel.org>
References: <E1X20mL-00083I-Sv@rmk-PC.arm.linux.org.uk>
 <yw1x4mz1f2t9.fsf@unicorn.mansr.com>
 <20140701171346.GP3705@n2100.arm.linux.org.uk>
 <yw1xzjgtdmas.fsf@unicorn.mansr.com> <20140701173547.GW28164@arm.com>
In-Reply-To: <20140701173547.GW28164@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_mgw8uSma0Mmji5Peh3Zp8w)
Content-type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2014, Will Deacon wrote:

> Hi Mans,
>=20
> On Tue, Jul 01, 2014 at 06:24:43PM +0100, M=E5ns Rullg=E5rd wrote:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > > As you point out, "bx lr" /may/ be treated specially (I've actually b=
een
> >=20
> > Most, if not all, Cortex-A cores do this according the public TRMs.
> > They also do the same thing for "mov pc, lr" so there will probably be
> > no performance gain from this change.  It's still a good idea though,
> > since we don't know what future cores will do.
>=20
> Funnily enough, that's not actually true (and is more or less what prompt=
ed
> this patch after discussion with Russell). There are cores out there that
> don't predict mov pc, lr at all (let alone do anything with the return
> stack).
>=20
> > > discussing this with Will Deacon over the last couple of days, who has
> > > also been talking to the hardware people in ARM, and Will is happy wi=
th
> > > this patch as in its current form.)  This is why I've changed all
> > > "mov pc, reg" instructions which return in some way to use this macro,
> > > and left others (those which are used to call some function and return
> > > back to the same point) alone.
> >=20
> > In that case the patch should be fine.  Your patch description didn't
> > make it clear that only actual returns were being changed.
>=20
> I'm led to believe that some predictors require lr in order to update the
> return stack, whilst others don't. That part is all horribly
> micro-architectural, so the current patch is doing the right thing by
> sticking to the ARM ARM but enabling us to hook into other registers later
> on if we choose.

May I suggest to have a patch with only the macro definition in it and=20
all this discussion in the commit log please?  The usage sites should be=20
done in a separate patch to make it clearer.


Nicolas

--Boundary_(ID_mgw8uSma0Mmji5Peh3Zp8w)--
