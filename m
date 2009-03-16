From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 16 Mar 2009 22:58:51 +0000
Subject: Re: [PATCH] sh: Move IRQ multi definition of DMAC to defconfig
Message-Id: <1237244331.6636.10.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <49BDC5DF.6070108@renesas.com>
In-Reply-To: <49BDC5DF.6070108@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, 2009-03-16 at 22:49 +0000, Adrian McMenamin wrote:

>=20
> Have just tested the current kernel in your (Paul's) git repo and
> although it doesn't (seem) to be suffering from the DMA issue now, it is
> still not booting - oom problems killing init:
>=20

....


> =EF=BF=BDStarting the hotplug events dispatcher: udevd.
> Synthesizing the initial hotplug events...udevd-event[954]: rename_netif:=
 error changing netif name eth0 to eth1: Device or resource busy
> done.
> [   29.005585] udevd invoked oom-killer: gfp_mask=3D0x1201d2, order=3D0, =
oomkilladj=3D-17
> [   29.013003] Stack: (0x8cd51ce4 to 0x8cd52000)
> [   29.017975] 1ce0:          8c0071ae 8cd51cf4 00000000 001201d2 8c05360=
6 8cd51cfc 00000041=20
> [   29.026904] 1d00: 8cd7c360 8c053c00 8cd51d2c 000000bc 8cd7c360 0000004=
1 00000124 8c2e4198=20


On the next three reboots the box cleanly booted twice and then failed a
third time - slightly differently - will now test with DMA off



