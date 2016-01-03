From: Simon Horman <horms@verge.net.au>
Date: Sun, 03 Jan 2016 21:07:07 +0000
Subject: Re: [PATCH] ARM: shmobile: alt: Add QSPI device to DT
Message-Id: <20160103210707.GC22806@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1448863990-16276-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWnyZbHiLEPn-6dEweBEXHzWr6o2KF2iCpzg2-OhZRVSw@mail.gmail.com>
 <20151201064149.GH16260@verge.net.au>
 <CAMuHMdXgr5FbS0_L8g0xdesFZ-utPH+G8VgXQKqXZd3t4OsXcw@mail.gmail.com>
 <20151218025410.GA10973@verge.net.au>
 <CAMuHMdWtv3Vin9jiwAsqZOmnuSYJeviCA6PuHt6C=-fvOSFsVA@mail.gmail.com>
In-Reply-To: <CAMuHMdWtv3Vin9jiwAsqZOmnuSYJeviCA6PuHt6C=-fvOSFsVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 18, 2015 at 11:07:23AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
>=20
> On Fri, Dec 18, 2015 at 3:54 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Dec 01, 2015 at 09:06:17AM +0100, Geert Uytterhoeven wrote:
> >> On Tue, Dec 1, 2015 at 7:41 AM, Simon Horman <horms@verge.net.au> wrot=
e:
> >> > On Mon, Nov 30, 2015 at 09:34:10AM +0100, Geert Uytterhoeven wrote:
> >> >> On Mon, Nov 30, 2015 at 7:13 AM, Simon Horman
> >> >> <horms+renesas@verge.net.au> wrote:
> >> >> > Enable the QSPI controller in the alt device tree.
> >> >> >
> >> >> > Based similar work for the silk board by by Vladimir Barinov and
> >> >> > Sergei Shtylyov.
> >> >> >
> >> >> > Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >> >> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> >> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >> >>
> >> >> Verified against Alt schematics and r8a7794 datasheet.
> >> >>
> >> >> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> >>
> >> >> I can't verify the FLASH layout. Note that p.11 of
> >> >> ALT_MiniMonitor_Manual(SPI_Boot)_Rev0.01_e.pdf shows a different
> >> >> FLASH layout for the second and third partition.
> >> >
> >> > Thanks. I see the following in v1.9.6 of the BSP[1]. Is it
> >> > the same as the document you referred to above?
> >> >
> >> >
> >> >                 partition@0 {
> >> >                         label =3D "loader";
> >> >                         reg =3D <0x00000000 0x00080000>;
> >> >                         read-only;
> >> >                 };
> >> >                 partition@40000 {
> >> >                         label =3D "user";
> >> >                         reg =3D <0x00080000 0x00580000>;
> >> >                         read-only;
> >> >                 };
> >> >                 partition@440000 {
> >> >                         label =3D "flash";
> >> >                         reg =3D <0x00600000 0x03a00000>;
> >> >                 };
> >> >
> >> >
> >> > [1] https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-backp=
ort.git/tree/arch/arm/boot/dts/r8a7794-alt.dts?h=3Drcar-gen2/v1.9.6&id=E1ac=
be074f36d96e901bf5346c50ee51da2ced42#n379
> >>
> >> No, the document specifies 3 partitions:
> >>   - SA0: loader program area, 16 KiB,
>=20
> Sorry, I missed a "Not used" part after that, and started miscounting zer=
oes
> on top of that :-(
>=20
> So the loader consumes 16 KiB out of the 256 KiB SA0 partition.
>=20
> >>   - SA1: System area, 16 KiB,
>=20
> Should be 256 KiB.
>=20
> >>   - SA2: User program area, remainder.
> >>
> >> FWIW, the unit addresses in the device nodes above are not consistent
> >> with their reg properties.
> >
> > My feeling is that we should follow the documentation.
> > Does this reflect the scheme it describes?
> >
> >
> >                 partitions {
> >                         #address-cells =3D <1>;
> >                         #size-cells =3D <1>;
> >
> >                         partition@0 {
> >                                 label =3D "loader";
> >                                 reg =3D <0x00000000 0x00004000>;
>=20
> reg =3D <0x00000000 0x00040000>;
>=20
> >                                 read-only;
> >                         };
> >                         partition@4000 {
>=20
> partition@40000
>=20
> >                                 label =3D "system";
> >                                 reg =3D <0x00004000 0x00004000>;
>=20
> reg =3D <0x00040000 0x00040000>;
>=20
> >                                 read-only;
> >                         };
> >                         partition@8000 {
>=20
> partition@80000
>=20
> >                                 label =3D "user";
> >                                 reg =3D <0x00008000 0x03ff8000>;
>=20
> reg =3D <0x00080000 0x03f80000>;
>=20
> >                         };
> >                 };
>=20
> I don't have an ALT. Does this match with the actual FLASH contents?

I'm a little unsure how to verify that.

> Sorry for the wreck on my side.

No problem.
