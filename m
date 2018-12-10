From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 10 Dec 2018 19:00:52 +0000
Subject: Re: [PATCH v3 3/4] serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure
Message-Id: <20181210190052.admylepukreo23j3@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5tpyya7ld3dzzz5w"
List-Id: <linux-sh.vger.kernel.org>
References: <20181210182154.20357-1-geert+renesas@glider.be>
 <20181210182154.20357-4-geert+renesas@glider.be>
In-Reply-To: <20181210182154.20357-4-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org


--5tpyya7ld3dzzz5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

>  	if (!port_lock_held)
>  		spin_unlock_irqrestore(&port->lock, flags);
> +	return -1;

-Esomething here...

>  		} else {
> +			if (sci_submit_rx(s, false))
> +				goto handle_pio;

and 'sci_submit_rx() < 0' here? I think it makes it more readable that
this is an error case then. 'if sci_submit_rx() do_something' sounds a
bit like the good case if boolean logic was used.

Thanks for picking this up again,

   Wolfram


--5tpyya7ld3dzzz5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwOt+AACgkQFA3kzBSg
KbYjoA//TB9WHPJ3lfL102I7I3tkN6qFdL7OIMPExLCZ21eaeC+DhOA81Dl04Hs/
auF2u2QiSkpLG8JApsZHOG9D5CybAeYVGH8DbXetyied02KaKrsCWEdH8HQfpn5A
1g4eGKGmoF91gDoNfJnJPuSadthetYvIG+tlNEFbbHyf//U6LaDpaEK97rsEztGR
LqdZcSL+CUsON4X/UoqQnoHkX/dimN28GVOsscqHuSnfXXij8R0zQttjx6vvtuNA
HEnXIGLPAAlAZoArfbYfCgwLzG+Cl1LgEGJIb7avh9qS+5YapSKOvTN3NeF6pyTH
uJUIE5hOoTKtacfFmIubRXQHAH2HyGH/eOteAN33NDtYL9X5R3GRCQwjcFF177jE
gNgBAOqPL+x6Y/NZOS0PvPI+j+hWo5U8Gubj/jNib1S6wj4ifRP4GlRcgoY5vuAf
XgbaMFEXsETeNWVk4H/7UeEh+tRx4MkBVqDKwR/ijVp23XuRUuuz+Pkl0rGSmPA7
gVRok/3TgXupprRtMcdepcNtz33fF82EowDyhGLzsDTg545Y7L1x+kfkcN5o3vRU
DysWALiWPcPC/X6Ei8gbvB0p3cncWgLA7WIst92mzAz8NWuT6ZvB6/PDZe67Xa/F
fT0GIpjxiK9jOiF2gyeli9ENkdWnA8iuVVPRCtuDVFP5LcYEwiM=
=iOlm
-----END PGP SIGNATURE-----

--5tpyya7ld3dzzz5w--
