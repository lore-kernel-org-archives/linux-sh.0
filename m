From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 12 Sep 2014 09:12:48 +0000
Subject: Re: [RFC 0/4] i2c: slave support framework for Linux devices
Message-Id: <20140912091247.GA1930@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <20140912085836.GS3755@pengutronix.de>
In-Reply-To: <20140912085836.GS3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> - If I understand correctly you cannot register an i2c slave without
>   also registering a master, right? I don't think this is troubling in
>   practice, is it?
>   For abstraction I would prefer to make these different concepts
>   though.

You need to register an adapter, yes. It does not need to populate the
callback for sending messages, so it could be slave only. But an adapter
is needed, because it is the glue between a client and the wired lines.

> - The IMHO most (even only?) useful slave is "i2cslvdev", i.e. a
>   userspace device. With that you wouldn't need device tree stuff, the
>   driver would just offer the device if supported. Userspace then could
>   care about the rest (slave address, functionality, ...).

I don't think it is the only useful one. A callback into userspace is
expensive, so stuff like shared memory (my eeprom simulator) or a shared
ringbuffer will come in handy, too. That being said, a slave device like
you described is probably the next user we see using the slave interface
:)


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUErkPAAoJEBQN5MwUoCm2szUQAIzsM6HalR9QyXoxm1VIsc94
tZ9vqH0tf4Sow6MDKaWpnFwPXRFKEjgQb+77yRQxoeGHONWyJR9L9yRlQmDMr/bv
pNkn/9Bj3mb2U+gjy9u/ERaSNCp+jl2TzYs3c52MdVBxwzNwNQgnPIO9BZ4NOZ93
fSA9Rr64EKHeKapk5aw7E8fRy3pAPDyd/Bn/LUu+k1kmLF2Ln+HNciu5z/9AgQVW
ayVYVlKqQazJHKuItOFKiGGIWxu8SSUnNXMZsoU1YGmztellCV4cnTT3mVeT96OL
yn3UdXD0es27clgdQbK1+UEJtuRC+M/0i/1Od7Seqq9LKe3ct4hiXCD8jdTRG6h0
9Ny2By5bjP3EJ5hHP33H4Cd/KrVlGG3dlXvXY35XpbzhAUuojt9dvlLO86jMpWTB
oxSZqWRuwosalxmNZd111yUshROIilZhik+0J8afF/Q0YBPnRE/sT1zX61UbMjsD
1K9Fqyu+FnV+s2OdQmxspHk1zxnfk1bThKzkVXPVswI5fuWsUNb9wlAGwPcENfSN
T1Q6cgx0Yr/0EY9clyMI+ZgFB3NIARnvHNNO0tf1v8FZ1jdZ7iKrn0hq5ujd6qKk
25TNcICJvPCyMjcF6aLzy1/omf87fwsMlvN1Ct0Y9+iuvbt8hGJeDCWM4EqqxuaF
qJutCcjW7LmQweBz/KwC
=lsjv
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
