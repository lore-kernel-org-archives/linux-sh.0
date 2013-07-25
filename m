From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 25 Jul 2013 06:41:08 +0000
Subject: Re: Mainline kernel on snowball
Message-Id: <20130725064108.GH1754@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20130725052317.GA25854@verge.net.au>
In-Reply-To: <20130725052317.GA25854@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Simon,

On Thu, Jul 25, 2013 at 02:23:17PM +0900, Simon Horman wrote:
> I apologise for the na=EFve nature of this question,
> but I do not seem to be able to make any progress of my own accord.
>=20
> I would like to boot the mainline kernel - ideally v3.10 and v3.11-rcX -
> on snowball. The reason being to verify CPU hotplug which
> seems to be broken on shmobile, though that is tangential to this post.
>=20
> My procedure, which does not work, is as follows.
> I have tried a number of different versions all with roughly
> the same result.
>=20
> 1. Build kernel
> # git checkout v3.10.2 # I have tried several over versions too.
> # make u8500_defconfig
> Edit .config to enable CONFIG_ARM_APPENDED_DTB
> # LOADADDR=3D0x100000 make uImage dtbs
>=20
> 2. Append dtb to zImage and recreate uImage
> mv arch/arm/boot/zImage arch/arm/boot/zImage.tmp
> cat arch/arm/boot/zImage.tmp arch/arm/boot/dts/snowball.dtb
There must be a redirection in the cat command, something like

	cat arch/arm/boot/zImage.tmp arch/arm/boot/dts/snowball.dtb > arch/arm/boo=
t/zImage

(I guess you have that as otherwise the following command would fail.)

> /bin/sh scripts/mkuboot.sh \
> 	-A arm -O linux -C none  -T kernel \
> 	-a 0x100000 -e 0x100000 -n 'Linux-3.10.2' \
> 	-d arch/arm/boot/zImage arch/arm/boot/uImage
>=20
> 3. Boot uImage from u-boot
> Snowball $ setenv ethaddr 3e:c4:73:05:d1:a1
> Snowball $ bootp;bootm
> smc911x: detected LAN9221 controller
> smc911x: phy initialized
> smc911x: MAC 3e:c4:73:05:d1:a1
> BOOTP broadcast 1
> *** Unhandled DHCP Option in OFFER/ACK: 28
> *** Unhandled DHCP Option in OFFER/ACK: 44
> *** Unhandled DHCP Option in OFFER/ACK: 28
> *** Unhandled DHCP Option in OFFER/ACK: 44
> DHCP client bound to address 10.3.3.146
> Using smc911x-0 device
> TFTP from server 10.3.3.135; our IP address is 10.3.3.146
> Filename 'snowball/uImage'.
> Load address: 0x100000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          ##########################################################
> done
> Bytes transferred =3D 2540191 (26c29f hex)
> ## Booting kernel from Legacy Image at 00100000 ...
>    Image Name:   'Linux-3.10.2'
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2540127 Bytes =3D  2.4 MB
>    Load Address: 00100000
>    Entry Point:  00100000
>    XIP Kernel Image ... OK
> OK
>=20
> Starting kernel ...
Try enabling DEBUG_LL and EARLY_PRINTK and pass "earlyprintk" on the
kernel commandline. That might make the kernel more talkative.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
