From: Simon Horman <horms@verge.net.au>
Date: Thu, 25 Jul 2013 08:26:39 +0000
Subject: Re: Mainline kernel on snowball
Message-Id: <20130725082639.GA25311@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130725052317.GA25854@verge.net.au>
 <20130725054036.GD31954@1wt.eu>
 <20130725072525.GC7654@verge.net.au>
 <20130725075203.GE31954@1wt.eu>
In-Reply-To: <20130725075203.GE31954@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Jul 25, 2013 at 09:52:03AM +0200, Willy Tarreau wrote:
> On Thu, Jul 25, 2013 at 04:25:25PM +0900, Simon Horman wrote:
> > > # cat /proc/cmdline=20
> > > console=3Dtty0 console=3DttyAMA2,115200n8  root=3DUUID=018e1580-e7e9-=
460b-95c5-236f6b87b13d rootwait ro fixrtc nocompcache vmalloc00M mem=128M@0=
 mali.mali_memdM@128M hwmem=168M@192M mem"M@360M mem_issw=3D1M@383M memd0M@=
384M
> >=20
> > Thanks. Rummaging around in the environment present in uboot I came up =
with
> > the following:
> >=20
> > bootargs=CAchepolicy=3Dwritealloc noinitrd init=3Dinit board_id=3D1 cra=
shkernel=3Dcrashkernel=3D1M@0x5600000 logo.nologo startup_graphics=3D1 mpco=
re_wdt.mpcore_margin59 loglevel=3D8 console=3DttyAMA2,115200n8 mem=128M@0 m=
ali.mali_memdM@128M
> > mem$M@192M hwmem=167M@216M mem_issw=3D1M@383M memd0M@384M vmalloc%6M
> >=20
> > Unfortunately neither this, nor the boot args you are using seem
> > to get me any further.
>=20
> OK, I'm attaching the config that works for me on 3.10-rc5 (not
> tested a new one yet). It boots with the cmdline above and with
> the DTB from the kernel.
>=20
> Hoping this helps,
> Willy
>=20

Thanks! I have something working now.

It seems that part of my problem may have been the compiler that
I was using. But that is just speculation at this time.
