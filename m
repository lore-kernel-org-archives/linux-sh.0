From: Simon Horman <horms@verge.net.au>
Date: Wed, 21 Jan 2015 01:59:45 +0000
Subject: Re: ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <20150121015943.GE30598@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150120113800.11062.65299.sendpatchset@little-apple>
In-Reply-To: <20150120113800.11062.65299.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Jan 21, 2015 at 08:50:38AM +0900, Simon Horman wrote:
> On Tue, Jan 20, 2015 at 08:38:00PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >=20
> > As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> > domain."), the APE6EVM legacy board support is know to be broken.
> >=20
> > The IRQ numbers of the GIC are now virtual, and no longer match the
> > hardcoded hardware IRQ numbers in the platform board code.
> >=20
> > To fix this, instantiate the GIC from platform board code when compiling
> > a legacy kernel, like is done for the sh73a0, r8a7740, r8a7778 and r8a7=
779
> > legacy code.
> >=20
> > Follows same style as the r8a7740 legacy GIC fix by Geert Uytterhoeven,
> > thanks to him for the initial work.
> >=20
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > ---
> >=20
> >  Written on top of renesas-devel-20150119-v3.19-rc5
> >=20
> >  Untested due to lack of working hardware, testing needed.
>=20
> Hi Magnus,
>=20
> thanks for your help with this. I have tested this and have
> both good and bad news.
>=20
> The bad news is that it does not appear to work :(
> The good news is that this means my setup is at least working (or not)
> consistently as I had brewed up the same change myself a few weeks ago
> and that also did not work :^)
>=20
> My na=C3=AFve guess is that the GIC setup for the r8a73a4 is somehow
> more complex or than calling gic_init() and that this is reflected
> in its DT - which seems more complex than for the r8a77{40,98,99} which
> we have been fixed in a manner very close to the patch you propose here.
>=20
> Please find attached two boot logs which may or may not be of any help.
>=20
> * renesas-devel-20150119-v3.19-rc5.txt: This is a boot of
>   renesas-devel-20150119-v3.19-rc5 using the ape6evm_defconfig.
>   It features the problem your patch tries to solve.
>=20
> * renesas-devel-20150119-v3.19-rc5+patched+earlyprintk: This is
>   a boot of renesas-devel-20150119-v3.19-rc5 with your patch applied,
>   and earlyprintk specified on the command line and
>   CONFIG_DEBUG_RCAR_GEN2_SCIF0 enabled in its config. Without the latter
>   two enhancements there is no console output at all.
>=20
> I'm not sure what the best way is to move forwards on this but
> I am quite happy to offer any assistance you need.

BTW, as I have just queued up the r8a73a0 multiplatform series,
which removes the code that your patch tries to fix, perhaps we
should consider letting this one go?
