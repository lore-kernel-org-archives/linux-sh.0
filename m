From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 20 Oct 2009 13:15:47 +0000
Subject: Re: [PATCH 04/14] sh: Obliterate the P1 area macros
Message-Id: <20091020131547.GA6729@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <22db0c702ba4b19699c05c38c26a6061bd0bbf40.1254861984.git.matt@console-pimps.org>
In-Reply-To: <22db0c702ba4b19699c05c38c26a6061bd0bbf40.1254861984.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, Oct 20, 2009 at 10:06:20PM +0900, Magnus Damm wrote:
> >> On Wed, Oct 7, 2009 at 6:22 AM, Matt Fleming <matt@console-pimps.org> =
wrote:
>
> > If image->start is a physical address, I don't think it's ever true that
> > image->start =3D __pa(image->start) beacuse you can't apply __pa() to a
> > physical address and get the same address, e.g.
> >
> > =A0 =A0 =A0 =A0 __pa(addr) !=3D __pa(__pa(addr))
> >
> > So, unless I'm mistaken this test can just be removed.
>=20
> I think the easist thing is that I submit a patch that simply removes the=
 test.
>=20

Sounds good to me!
