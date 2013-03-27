From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 27 Mar 2013 10:22:32 +0000
Subject: Re: drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit declaration of function 'ioport_unm
Message-Id: <5152C868.5030801@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2VSTGXEXXSWVTWEGOQMEE"
List-Id: <linux-sh.vger.kernel.org>
References: <20130327083110.GB11489@localhost>
In-Reply-To: <20130327083110.GB11489@localhost>
To: linux-sh@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VSTGXEXXSWVTWEGOQMEE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/27/2013 10:41 AM, Paul Mundt wrote:
> On Wed, Mar 27, 2013 at 04:31:10PM +0800, Fengguang Wu wrote:
>>
>> Hi Stephane,
>>
>> FYI, kernel build failed on
>>
>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux m=
aster
>> head:   de55eb1d60d2ed0f1ba5e13226d91b3bfbe1c108
>> commit: 2b61972b74219d21ef1e91178349bdb840357688 can: sja1000: add sup=
port for PEAK-System PCMCIA card
>> date:   1 year, 1 month ago
>> config: make ARCH=3Dsh allyesconfig
>>
>> All error/warnings:
>>
>>    In file included from drivers/net/can/sja1000/peak_pcmcia.c:28:0:
>>    drivers/net/can/sja1000/sja1000.h:59:0: warning: "REG_SR" redefined=
 [enabled by default]
>>    arch/sh/include/asm/ptrace_32.h:25:0: note: this is the location of=
 the previous definition
>>    drivers/net/can/sja1000/peak_pcmcia.c: In function 'pcan_free':
>>>> drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit declara=
tion of function 'ioport_unmap' [-Werror=3Dimplicit-function-declaration]=

>>    drivers/net/can/sja1000/peak_pcmcia.c: In function 'pcan_probe':
>>>> drivers/net/can/sja1000/peak_pcmcia.c:672:2: error: implicit declara=
tion of function 'ioport_map' [-Werror=3Dimplicit-function-declaration]
>>    drivers/net/can/sja1000/peak_pcmcia.c:672:20: warning: assignment m=
akes pointer from integer without a cast [enabled by default]
>>    cc1: some warnings being treated as errors
>>
> This would no doubt be due to the defconfig selecting NO_IOPORT. This
> driver probably needs a HAS_IOPORT depends.

Stephane, can we use pcmcia_map_mem_page() instead of ioport_map() like
in the ems_pcmcia driver?

http://lxr.free-electrons.com/source/drivers/net/can/sja1000/ems_pcmcia.c=
#L286

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2VSTGXEXXSWVTWEGOQMEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFSyGwACgkQjTAFq1RaXHPnCwCgmRnI0iVIMnoQAFZOaKjYl/EV
w3oAmwfwmKpta5cqgOqCL1Q0YtOntusm
=+502
-----END PGP SIGNATURE-----

------enig2VSTGXEXXSWVTWEGOQMEE--
