From: Simon Horman <horms@verge.net.au>
Date: Thu, 25 Jul 2013 07:25:25 +0000
Subject: Re: Mainline kernel on snowball
Message-Id: <20130725072525.GC7654@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130725052317.GA25854@verge.net.au>
 <20130725054036.GD31954@1wt.eu>
In-Reply-To: <20130725054036.GD31954@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Jul 25, 2013 at 07:40:36AM +0200, Willy Tarreau wrote:
> Hi Simon,
>=20
> On Thu, Jul 25, 2013 at 02:23:17PM +0900, Simon Horman wrote:
> > Hi,
> >=20
> > I apologise for the na=C3=AFve nature of this question,
> > but I do not seem to be able to make any progress of my own accord.
> >=20
> > I would like to boot the mainline kernel - ideally v3.10 and v3.11-rcX -
> > on snowball. The reason being to verify CPU hotplug which
> > seems to be broken on shmobile, though that is tangential to this post.
> >=20
> > My procedure, which does not work, is as follows.
> > I have tried a number of different versions all with roughly
> > the same result.
> >=20
> > 1. Build kernel
> > # git checkout v3.10.2 # I have tried several over versions too.
> > # make u8500_defconfig
> > Edit .config to enable CONFIG_ARM_APPENDED_DTB
> > # LOADADDR=3D0x100000 make uImage dtbs
> >=20
> > 2. Append dtb to zImage and recreate uImage
> > mv arch/arm/boot/zImage arch/arm/boot/zImage.tmp
> > cat arch/arm/boot/zImage.tmp arch/arm/boot/dts/snowball.dtb
> > /bin/sh scripts/mkuboot.sh \
> > 	-A arm -O linux -C none  -T kernel \
> > 	-a 0x100000 -e 0x100000 -n 'Linux-3.10.2' \
> > 	-d arch/arm/boot/zImage arch/arm/boot/uImage
> >=20
> > 3. Boot uImage from u-boot
> > Snowball $ setenv ethaddr 3e:c4:73:05:d1:a1
> > Snowball $ bootp;bootm
> > smc911x: detected LAN9221 controller
> > smc911x: phy initialized
> > smc911x: MAC 3e:c4:73:05:d1:a1
> > BOOTP broadcast 1
> > *** Unhandled DHCP Option in OFFER/ACK: 28
> > *** Unhandled DHCP Option in OFFER/ACK: 44
> > *** Unhandled DHCP Option in OFFER/ACK: 28
> > *** Unhandled DHCP Option in OFFER/ACK: 44
> > DHCP client bound to address 10.3.3.146
> > Using smc911x-0 device
> > TFTP from server 10.3.3.135; our IP address is 10.3.3.146
> > Filename 'snowball/uImage'.
> > Load address: 0x100000
> > Loading: ##############################################################=
###
> >          ##############################################################=
###
> >          ##############################################################=
###
> >          ##############################################################=
###
> >          ##########################################################
> > done
> > Bytes transferred =3D 2540191 (26c29f hex)
> > ## Booting kernel from Legacy Image at 00100000 ...
> >    Image Name:   'Linux-3.10.2'
> >    Image Type:   ARM Linux Kernel Image (uncompressed)
> >    Data Size:    2540127 Bytes =3D  2.4 MB
> >    Load Address: 00100000
> >    Entry Point:  00100000
> >    XIP Kernel Image ... OK
> > OK
> >=20
> > Starting kernel ...
> >=20
> >=20
> > This is as far as it gets.
>=20
> Are you sure you have the correct bootargs by default ? It was a
> pain for me to figure the correct ones, and I finally found them
> in the boot scripts. Mine is booted with this :
>=20
> # cat /proc/cmdline=20
> console=3Dtty0 console=3DttyAMA2,115200n8  root=3DUUID=018e1580-e7e9-460b=
-95c5-236f6b87b13d rootwait ro fixrtc nocompcache vmalloc00M mem=128M@0 mal=
i.mali_memdM@128M hwmem=168M@192M mem"M@360M mem_issw=3D1M@383M memd0M@384M

Thanks. Rummaging around in the environment present in uboot I came up with
the following:

bootargs=CAchepolicy=3Dwritealloc noinitrd init=3Dinit board_id=3D1 crashke=
rnel=3Dcrashkernel=3D1M@0x5600000 logo.nologo startup_graphics=3D1 mpcore_w=
dt.mpcore_margin59 loglevel=3D8 console=3DttyAMA2,115200n8 mem=128M@0 mali.=
mali_memdM@128M
mem$M@192M hwmem=167M@216M mem_issw=3D1M@383M memd0M@384M vmalloc%6M

Unfortunately neither this, nor the boot args you are using seem
to get me any further.

> # uname -a
> Linux snowball 3.10.0-rc5-snowball #2 SMP Fri Jun 14 09:19:28 CEST 2013 a=
rmv7l GNU/Linux
>=20
> I don't have the CONFIG_ARM_APPENDED_DTB set, instead I have copied
> the dtb on the flash since u-boot supports it (I find this boot
> procedure quite annoying btw).

Thanks.

I have now also tried the following without CONFIG_ARM_APPENDED_DTB set.

Snowball $ setenv ethaddr 3e:c4:73:05:d1:a1
Snowball $ bootp=20
smc911x: detected LAN9221 controller
smc911x: phy initialized
smc911x: MAC 3e:c4:73:05:d1:a1
BOOTP broadcast 1
*** Unhandled DHCP Option in OFFER/ACK: 28
*** Unhandled DHCP Option in OFFER/ACK: 44
*** Unhandled DHCP Option in OFFER/ACK: 28
*** Unhandled DHCP Option in OFFER/ACK: 44
DHCP client bound to address 10.3.3.146
Using smc911x-0 device
TFTP from server 10.3.3.135; our IP address is 10.3.3.146
Filename 'snowball/uImage'.
Load address: 0x100000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ##########################################################
done
Bytes transferred =3D 2540999 (26c5c7 hex)
Snowball $ tftp 0xf00000 snowball/snowball.dtb
smc911x: detected LAN9221 controller
smc911x: phy initialized
smc911x: MAC 3e:c4:73:05:d1:a1
Using smc911x-0 device
TFTP from server 10.3.3.135; our IP address is 10.3.3.146
Filename 'snowball/snowball.dtb'.
Load address: 0xf00000
Loading: ###
done
Bytes transferred =3D 16722 (4152 hex)
Snowball $ bootm 0x100000 - 0xf00000
## Booting kernel from Legacy Image at 00100000 ...
   Image Name:   'Linux-3.10.2'
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2540935 Bytes =3D  2.4 MB
   Load Address: 00100000
   Entry Point:  00100000
   XIP Kernel Image ... OK
OK

Starting kernel ...



