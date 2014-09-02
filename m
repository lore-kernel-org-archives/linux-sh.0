From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 02 Sep 2014 22:18:58 +0000
Subject: Re: [PATCH 08/11] i2c: rcar: remove spinlock
Message-Id: <20140902221858.GA1267@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
 <1401263086-13720-9-git-send-email-wsa@the-dreams.de>
 <53F7D83A.5030903@cogentembedded.com>
 <5406404A.7090509@cogentembedded.com>
In-Reply-To: <5406404A.7090509-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>    After looking at the code, it looks like it was a false alarm on my side.
> The I2C interrupts are disabled here and other threads should be locked out
> by the I2C core locks. So it doesn't make sense to hold IRQs disabled during
> a possibly long polling loop in rcar_i2c_bus_barrier(). So I'll just repost
> the revert patch (if still needed).

Nope. Thanks for looking into it.


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBkJSAAoJEBQN5MwUoCm227cP/jOC6o1z4waCZRIqCPSC9dq+
sXDtcJV51rRD9twDNselSXa+shVKEv64r5aIJs4jso4Ts2Vu/zdcBifgfHFoTABe
4ndruPa4gYtPu0dbrNewOpcleZGTl6CqLW+InjodHlG17jC2j7PzOBEVrmCjEDin
oySMeBQYjsIl7y/qyqOS4vY9yZsrvWMLFAkFflGRxrXyvVl1vrj22b1ivrymM+p3
nXSbP9PrFK3cUbusuMdfIcV0mKVuMm0AJZURxm0RTBF7jb2pgjSa35eajx/XZPYd
M2xX0J8uvNCBID8ut2iV1mM9i3tOgjynRe3plZSgPu3TlSdYwLkm+pSkM3tY9BAO
4ArnIa2DrmRRye+45M3lCbjQJbfFNccOv0zQGYHKXLPiaUpWC7FVmJnWl8dqXDd5
M7zsoruqJLe9RiRZoPhdQwshtbk+8HW31+/cz/gaByDhaQQBWODVlscUx8n3aHmB
n5RCmDJCdeOxY+FvBB3CDvyLSGzwgGLf3kCCm8+YuSE6yqgEy0JnKqaPZBmHLJu7
VERF442EGHtKbLzcgiRkd/UffLmWArtKquPTQTAHh9ZvmX/6ezSpgtbz5NzARxae
oDuu+YNpBlkXaLMxy6peWXGIPIVFLt0UDqsNeixImannE5N4U01AgsgN76ZJR6e3
c3tXDgb/ynLGgYlGZMHk
=lIZu
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
