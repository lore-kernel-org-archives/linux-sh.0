From: Marc Dietrich <marvin24@gmx.de>
Date: Fri, 12 Sep 2014 09:06:49 +0000
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Message-Id: <7627175.tG5quZH0VN@fb07-iapwap2>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1587627.2fD0quCvaU"
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <9935938.eKOCvCAtLt@fb07-iapwap2> <20140912083348.GA1289@katana>
In-Reply-To: <20140912083348.GA1289@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart1587627.2fD0quCvaU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Am Freitag, 12. September 2014, 10:33:48 schrieb Wolfram Sang:
> > > Why do you want DT to be involved at all?
> > 
> > Imagine a device which supports both, slave or master mode. The driver
> > needs to know in which mode it should operate. This cannot be hard coded,
> > because on different boards, different modes can be used.
> 
> Okay, it sounds weird to me that a device is not able to switch between
> master and slave, but if you say so. Also, solving this issue would also
> handle potential weird IP blocks which can be slave only, right?

I didn't said device. I meant the driver (software) needs to know if which 
mode to operate the device. DT has to provide just enough information to 
select the right mode depending on the board implementation.

> What if you use two different adapter drivers or compatibles? One for
> master-mode, one for slave-mode (slave could leave algo->master_xfer
> empty, so the slave mode driver cannot send packets). I'm brainstorming
> here, so while it should work IMO I will probably need a second thought.
> 
> So, in the DT you would have a block registering the I2C slave core
> which binds to a simple driver providing reg_slave/unreg_slave and
> pass on the slave-event. Then you could instantiate slave clients as
> said before.
> 
> Maybe we need a real world example?

ok, take our embedded controller driver (in staging/nvec) as an example. It's 
basicly an MFD connecting keyboard, mouse, power, gpio, and some other stuff 
to the soc. The MFD operates in master mode while the SOC is the I2C slave. 
Theoretically, these roles could also switch (but that's not defined in the 
nvec protocol).

So the i2c client driver sits in between the adapter (in slave or master mode) 
and the the MFD children (keyboard, mouse, ...) and provides read/write/cb 
functions (nvec uses a side channel gpio to be able to initiate writes on its 
own) to its children. The MFD children don't care about how the i2c 
communication is done, but the client driver needs to decide in which mode it 
should talk to the EC. If this is not autodetectable, the mode needs to be 
provided by the device tree.

In this case you cannot use separate drivers for master and slave mode (or you 
would need another layer to hide the driver multiplexing).

> > The point is, that if we define a dt binding for master device on slave
> > adapters it will be there forever. So even if it makes no sense for the
> > example eeprom simulator (or even our embedded controller), it may make
> > sense for other or future devices.
> 
> I don't know what you mean here. Again, an example might help?

I just wanted to say that the discussion here should find a *generic* way to 
distinguish slave and master clients on the i2c bus by using a proper DT 
binding.

Marc

--nextPart1587627.2fD0quCvaU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJUEreqAAoJEKyeR39HFBtohnkIAIYKTkRFpQtlFVC5NojsYh/E
ylFtmRd1cOXF+SRvBNP++OPcMSyfx07tS/6dheEhmtK7ue3vKzWV2cVGMw7ue2mn
KfC9damQZj1S2DPbFxXFcV11qqJOh72D7LYcFbI/Vhd0Of5YK9cE8oc6izx6arET
LDbayFvhd/JyWTqTyxBzd4AQZKS1YL4g23gSanSLt8IqdAf9MM2k9L4SaMp0XvV9
GbxEJ8H4OvsHwgvGLFxlX0tUYYe6wxu9laGyGskdap5zgb4wIas2v8qn5L4vwr8r
9vK+xqJOivPKHsZY8Aej/LR3I1KXQ2IrgJ7YbJZw/Qu19Pjx7u8QzE/PwYAuz9Q=
=AsXP
-----END PGP SIGNATURE-----

--nextPart1587627.2fD0quCvaU--

