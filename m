From: Harley Laue <losinggeneration@gmail.com>
Date: Tue, 15 Jul 2008 01:20:21 +0000
Subject: Re: [Fwd: Gentoo install]
Message-Id: <487BFB55.3010609@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1216070824.6459.6.camel@localhost.localdomain>
In-Reply-To: <1216070824.6459.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Adrian McMenamin wrote:
> apologies sent this to the SF list by mistake. I know this isn't a
> kernel issue but i suspect the real knowledge of how to do this is
> here...
> 
> Is there a guide anywhere to how I can install gentoo on my Dreamcast?
> 
> I have got a stage 3 tarball and installed the latest portage snapshot,
> but it seems like madness to me to try to compile packages natively and
> I have read fragmentary emails suggesting that I can get some sort of
> x-compile system up and running.
> 
> But I cannot find anything coherent that explains how to do it? Any
> clues/experience?

It's been awhile since I played with this specifically. There were
several different ways. One is explained
http://www.gentoo.org/proj/en/base/embedded/cross-development.xml
Another was using Overlays to do basically the same thing. You can use
this to build programs that are easy to put into the NFS (one of the
easier setups IMO)

The other option would be to setup a Gentoo cross compiler to use with
distcc then to compile things from the Dreamcast but offloading the
actual compiling to another system. When I did this I didn't have the
Dreamcast doing any compiling but rather offloading all compiling to my
desktop.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkh7+1UACgkQulFr2MEc2vvDLACeIC74AyaRiilAVNxw9fbHaGol
6nkAn0zaEOWhGGtOjVpifFW7zaCqVi7M
=Ul4d
-----END PGP SIGNATURE-----
