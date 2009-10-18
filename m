From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 18 Oct 2009 15:31:04 +0000
Subject: Re: [PATCH 04/14] sh: Obliterate the P1 area macros
Message-Id: <20091018153104.GA6504@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <22db0c702ba4b19699c05c38c26a6061bd0bbf40.1254861984.git.matt@console-pimps.org>
In-Reply-To: <22db0c702ba4b19699c05c38c26a6061bd0bbf40.1254861984.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Oct 15, 2009 at 03:05:32PM +0900, Magnus Damm wrote:
> Hey Matt,
>=20
> [CC Morimoto-san]
>=20
> Thanks for your work on this!
>=20

Hi Magnus, no problem. Sorry I haven't replied more quickly, I've been
at ELC Europe this week.

> On Wed, Oct 7, 2009 at 6:22 AM, Matt Fleming <matt@console-pimps.org> wro=
te:
> > =A0* Map an address to a certain privileged segment
> > diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_ke=
xec.c
> > index 7ea2704..de7cf54 100644
> > --- a/arch/sh/kernel/machine_kexec.c
> > +++ b/arch/sh/kernel/machine_kexec.c
> > @@ -49,7 +49,7 @@ int machine_kexec_prepare(struct kimage *image)
> > =A0 =A0 =A0 =A0/* older versions of kexec-tools are passing
> > =A0 =A0 =A0 =A0 * the zImage entry point as a virtual address.
> > =A0 =A0 =A0 =A0 */
> > - =A0 =A0 =A0 if (image->start !=3D PHYSADDR(image->start))
> > + =A0 =A0 =A0 if (image->start !=3D __pa(image->start))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL; /* upgrade your kexec-to=
ols */
> >
> > =A0 =A0 =A0 =A0return 0;
>=20
> This change unfortunately breaks kexec. The PHYSADDR() macro masks but
> __pa() subtracts so this breaks the physical address case.
>=20
> Do you have any idea how to keep the previous behaviour? Worst case we
> can just remove this check - it's been a while since I updated
> kexec-tools now.
>=20

Damn, sorry I missed this. Is image->start a virtual address? If so,
this check doesn't make sense when CONFIG_PMB is enabled because virtual
addresses do not have to be mapped to physical addresses 1:1.

If image->start is a physical address, I don't think it's ever true that
image->start =3D __pa(image->start) beacuse you can't apply __pa() to a
physical address and get the same address, e.g.

	 __pa(addr) !=3D __pa(__pa(addr))

So, unless I'm mistaken this test can just be removed.
