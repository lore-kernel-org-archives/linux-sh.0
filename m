From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 25 Aug 2014 14:33:16 +0000
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Message-Id: <20140825143316.GA1285@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
List-Id: <linux-sh.vger.kernel.org>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com>
 <20140824064520.GA2578@katana>
 <53F9CCE7.3010006@cogentembedded.com>
 <20140825034009.GA2795@katana>
 <53FB1F90.6080704@cogentembedded.com>
In-Reply-To: <53FB1F90.6080704-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>    Ah, I misunderstood you. However, I don't quite understand why you want
> to combine revert and the mentioned updates...

As I understood from your previous mail, a plain revert is less broken
but still broken. Applying a correct fix is my preferred way.


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+0ksAAoJEBQN5MwUoCm239gQAIQznlV3fZxY7sIMruedhqoq
zJvW2hp3vEEHGMlCOFa7vZzOzd8CeDLafRAdpKw+QXBOC+/VMotBnCJeJCXWtZ7t
ugr05CskAVmxWON2QPHN0HoTj2LdwodekQXb+DeW0rCYECTAXwguACdNxuIKC4nq
xh3kJkSCxJPW9tYOVoGruQZhVldXqT8IuyLFAcJQ3VobJvOaGzcfwv/kxw61Oleo
bmKjvr2YjhtrmkPb1rpZkAoh02et5o0V8diam8vQVznXjnyvk2GL4wmBOgevw5TH
jEPWROfsNQ/Q1TOpfPCdTAPD1hUImevCgjCUsQZ0lXqDzfVNrgR2L2oQZ6fGUgfG
TODKQXCc9esJvSsahkyA4D65KhTe7fRK57VPlAELE3nK3TBrmqijumwb2B6gTpM+
yezn5cfzaPWAvqi57wXP0ziYzkRGQJiNo8FeFugZQhbKkHpfeffcNYRLanUbA55+
UsQNWemii4FHNCbwvC8PbnhJJk6NtZry8VI6Z+HPFFeLX8vCTRUC1Ro2uX8yhosk
t0cWjE7kG8zybMHukLoRFVI4Nly7OTOGINBs8LQYsyixakAp/6+ddCHTOK0SVMYg
G3gtHBde+Nht5B0Mx1sFntblVEncMKPQ56kcVrdfbcvMct1Cg/a6EDBH/XbJgd5v
L8D/vA2LhEisB66XaFa5
=Mixq
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
