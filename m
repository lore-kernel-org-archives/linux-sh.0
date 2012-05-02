From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Wed, 02 May 2012 13:55:05 +0000
Subject: Re: [PATCH v3 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <1335966905.10293.59.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-28FnmArM4cUD86pXbWNc"
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335955122.10293.39.camel@sauron.fi.intel.com>
 <CABYn4szhjH0N_DsGc=O0TtJZNUja1KDzZ7HWTnR5nQvnxZEVPQ@mail.gmail.com>
 <1335960145.10293.48.camel@sauron.fi.intel.com>
 <CABYn4swraZL0Zi56xfPyZQ4vo1jK9f4KFLUZxEPrZRO4K83URg@mail.gmail.com>
In-Reply-To: <CABYn4swraZL0Zi56xfPyZQ4vo1jK9f4KFLUZxEPrZRO4K83URg@mail.gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org


--=-28FnmArM4cUD86pXbWNc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-02 at 15:41 +0200, Bastian Hecht wrote:
> Ok I'm slowly but surely fighting my way through it. Though I want to
> add an advisor here:
> Don't do this on your crappy laptop like I do. I guess I will move to
> my 8Gb RAM desktop machine for this in the future ;)

Yeah, I run it on a powerful PC. I need to update the README file - but
if you send a patch - will be appreciated.

> There's only 1 thing I don't completely grasp: you pass a target path
> to aiaiai/test-patchset and a working tree. I didn't manage to get it
> take the l2_mackerel_defconfig from one and compile the patches on top
> of the other.

Yeah, this is in my TODO list to teach aiaiai to take defconfig files
which are not part of the tree. So you basically need to copy the
l2-mackerel_defconfig file to your tree and commit it, so that the
defconfig is part of the git tree you are testing against.

But I want to teach test-patchset to accept just stand-along defconfig
files.

The reason it is implemented the way it is implemented because it was
originally done for an internal project where we have a couple of
defconfigs which are part of the project tree.

>  So I simply copied the defconfig to my kernel dir and
> ran the command manually.

You should also commit it, of course. Because the way aiaiai works it
first clones your tree and then work with the clone. This is done to
make sure your tree is preserved intact.


--=20
Best Regards,
Artem Bityutskiy

--=-28FnmArM4cUD86pXbWNc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPoTy5AAoJECmIfjd9wqK0B+IQAJ1cKXuRXxcn/RtU+MnVdn5j
4hO83uo5GqAF+61bXIky03idAFVvPC7TpkiZq52AnipZ7o2w0mhnNTOrzDeDP4aV
pxEClCQKxwseVNIzXMl38ry0VRoRdxvCD5WCpGR0FhmDgLWBYKgxIzEyaRBUaf6e
X8nl5JDISAOd/QbiHjh2uwHpYPmpjzJGJd+EDP3GjGn2J+JDKsic4syZDJ5Pq4hR
r5EfgCvL/QyxvXPvDpw9klMaxm6KMkfbZyIs6WgTA7UZyVtqEjoZVRQBturzvGxZ
Oh1dXDqpoqQYJ3wmbNSKZ72W6Egziaoi218OdmQ/xQjrbNiVBcjSbWrMJaEZuImi
7/OB6B3oHAE74AlWrX+eSo9BxyuVpBrl1b3HVTUG+mxcN3253lVk6jKgV/kwcY2T
lF+MjPsJo6w0KtQ8Yyvmz6hrw7yjFo0Qa2sPlN+SJooCCjxspc5Crv8vqaXnLMoz
5HgbZyfmOAOcvURYmOvVxaRdR/fYZFFvyh9sSXWwSvIRgRJYkmYrSmUMK99LD73v
e7/Sr16o3HlJjUD/QRtQLxhpihDKMU4Q6DZJGZEydKDqF8rMhKCm7hXT9X05/GiZ
j0a3ey0/5PpMxDQnnUJbSo83IkBb6/B9fOnMre+KcdZ+yQZ1+lmRNJR99eeFFj37
98dkHmemcl1ao/DUoyD3
=s9sV
-----END PGP SIGNATURE-----

--=-28FnmArM4cUD86pXbWNc--

