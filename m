From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 19 Mar 2015 20:11:37 +0000
Subject: Re: [PATCH 2/3] Documentation: i2c: describe the new slave mode
Message-Id: <20150319201137.GY10068@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426164123-8853-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Danin <danindrey@mail.ru>, Marc Dietrich <marvin24@gmx.de>, Debora Grosse <debora@mds.com>, linux-kernel@vger.kernel.org

Hello Wolfram,

On Thu, Mar 12, 2015 at 01:42:02PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/i2c/slave-interface | 178 ++++++++++++++++++++++++++++++++=
++++++
>  Documentation/i2c/summary         |   4 -
>  2 files changed, 178 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/i2c/slave-interface
>=20
> diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slave-=
interface
> new file mode 100644
> index 00000000000000..3df6c37191c86c
> --- /dev/null
> +++ b/Documentation/i2c/slave-interface
> @@ -0,0 +1,178 @@
> +Linux I2C slave interface description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> +
> +by Wolfram Sang <wsa@sang-engineering.com> in 2014-15
> +
> +Finally, Linux can also be an I2C slave in case I2C controllers have sla=
ve
> +support. Besides this HW requirement, one also needs a software backend
I wouldn't have written "Finally, ...". While it's great that we have
slave support now, being enthusiastic here looks strange if someone
reads it while slave support has become "normal".

> +providing the actual functionality. An example for this is the slave-eep=
rom
> +driver, which acts as a dual memory driver. While another I2C master on =
the bus
> +can access it like a regular eeprom, the Linux I2C slave can access the =
content
> +via sysfs and retrieve/provide information as needed. The software backe=
nd
> +driver and the I2C bus driver communicate via events. Here is a small gr=
aph
> +visualizing the data flow and the means by which data is transported. The
> +dotted line marks only one example. The backend could also use e.g. a ch=
aracter
> +device, or use in-kernel mechanisms only, or something completely differ=
ent:
Or something self contained, so the userspace part is actually optional
(but probably present most of the time).

Another slave backend I have in mind is a bus-driver tester. That
wouldn't necessarily need a userspace part.

> +              e.g. sysfs        I2C slave events        I/O registers
> +  +-----------+   v    +---------+     v     +--------+  v  +-----------=
-+
> +  | Userspace +........+ Backend +-----------+ Driver +-----+ Controller=
 |
> +  +-----------+        +---------+           +--------+     +-----------=
-+
> +                                                                | |
> +  ----------------------------------------------------------------+--  I=
2C
> +  --------------------------------------------------------------+----  B=
us
> +
> +Note: Technically, there is also the I2C core between the backend and the
> +driver. However, at this time of writing, the layer is transparent.
s/this/the/ ?
> +
> +
> +User manual
> +=3D=3D=3D=3D=3D> +
> +I2C slave backends behave like standard I2C clients. So, you can instant=
iate
> +them like described in the document 'instantiating-devices'. A quick exa=
mple
> +for instantiating the slave-eeprom driver from userspace:
> +
> +  # echo 0-0064 > /sys/bus/i2c/drivers/i2c-slave-eeprom/bind
> +
> +Each backend should come with separate documentation to describe its spe=
cific
> +behaviour and setup.
> +
> +
> +Developer manual
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +I2C slave events
> +----------------
> +
> +The bus driver sends an event to the backend using the following functio=
n:
> +
> +	ret =3D i2c_slave_event(client, event, &val)
> +
> +'client' describes the i2c slave device. 'event' is one of the special e=
vent
> +types described hereafter. 'val' holds an u8 value for the data byte to =
be
> +read/written and is thus bidirectional. The pointer to val must always be
> +provided even if val is not used for an event. 'ret' is the return value=
 from
Does that mean that I have to pass a valid address, or can I use NULL,
too?

> +the backend. Mandatory events must be provided by the bus drivers and mu=
st be
> +checked for by backend drivers.
Currently all commands are mandatory. Does it make sense to mark the
events accordingly already now? Do you expect the set of events to
grow?

> +* I2C_SLAVE_READ_PROCESSED (mandatory)
> +
> +'val': backend returns next byte to be sent
> +'ret': always 0
> +
> +The bus driver requests the next byte to be sent to another I2C master in
> +'val'. Important: This does not mean that the previous byte has been ack=
ed or
> +even has been put on the wires! Most hardware requests the next byte whe=
n the
> +previous one is still to be shifted out to ensure seamless transmission.=
 If the
> +master stops reading after the previous byte, the next byte is never use=
d. It
> +probably needs to be sent again on the next I2C_SLAVE_READ_REQUEST, depe=
nding a
> +bit on your backend.
I didn't look into the actual implementation yet, but if I understand
correctly a slave driver only sees I2C_SLAVE_READ_REQUESTED once and
then only one I2C_SLAVE_READ_PROCESSED per byte, right? Does the slave
driver gets noticed somehow if a previously requested byte doesn't make
it on the wire? Otherwise you cannot correctly maintain e.g. the current
read position of the eeprom driver, do you? (That's a bit like one of
the problems with buffer support you pointed out further down.)

> +
> +* I2C_SLAVE_STOP (mandatory)
> +
> +'val': unused
> +'ret': always 0
> +
> +A stop condition was received. This can happen anytime and the backend s=
hould
> +reset its state to be able to receive new requests.
While being obvious when you understood i2c, "reset its state" could be
misleading. Only the transfer specific stuff should be reset. I expect
the eeprom example to not reset the current position on STOP.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
