From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 18 Jan 2015 12:59:39 +0000
Subject: Re: Bug#775611: [sh]: FTBFS due to unknown compiler option '-m32'
Message-Id: <54BBAE3B.8020708@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1421575095.31046.99.camel@decadent.org.uk>
In-Reply-To: <1421575095.31046.99.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 01/18/2015 12:52 PM, Ben Hutchings wrote:
> The next question is whether recordmcount.c works properly for SH.
> 
> Adrian, can you check whether ftrace seems to work on the kernel
> built with HAVE_C_RECORDMCOUNT selected?  (See
> Documentation/trace/ftrace.txt and particularly the 'function'
> example.)

I guess that involves also installing the kernel and running it? The
reason why I ask is that I currently don't have physical access to
any of the SH4 machines yet as I am still waiting for Nobuhiro Iwamatsu
to send me one of the spare boards he has.

Thus, if the kernel locks up the kernel for whatever reason, I am a
bit lost until Nobuhiro can reset the machine. Having my own local
SH4 machine would simplify things dramatically.

Adrian

- -- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJUu646AAoJEHQmOzf1tfkT7V4P/R13gZfztFdJhC2t7k5naDAh
IcS5dwdeilCqRHEGm0Su5eGV7d6taZASplcKahDgw14VlQ/7tpSlMNQU2AYj8IKo
bQ8xJfjmwznPOE3U/4p/dH2whfQWXowLoTKIO/Ayd06N/swP2kfMvwQMbVlxfbm6
fy5BmDry7NQQO39cCfIA1GPo4Eme1VHLaG/mRRDvuXWaujX/CFA9aFdiiZ2ZRQjp
achH6zIb/9TdflWVNdMbadusUaZZgkin7p3Ky4jC0kk9pWtcWRR4zZdBGoKFrr3N
HsdPVJScNWZeaaH7G//3L9WNgITQHC+gjoxuBrVN4NuVU5TIoHitsdhQGdJ96wJZ
TENKenPiCQxwwLwljSjJ6lV+V1B7YT1nOpOBwK5jePzqIUL3ymejigwPXNQqlwev
LK4I2tGMWDyh1VwZz0lwmRLh+Nu1NdPFzlu6981OAWOO8rSpcxzGTp5ipNPPY3VY
j2MC0nibwx74DJYHzgDGCUdGN5lvDe0qNtwkqyKgnKCjsVdNHKZVEynFOfdmPSLz
2YfY8PZFRgmb5/Fb59990mvfEkY+No4o67yZP6k9jBcfAY7E/jTFjpzKQQjYdkhB
q3hKl2M5fcvSKMCMrDWSOPEbC4By0arYvsDVVUecTvgecP/TGeBiJpPLVY9gLSAx
JlAltcZjGayAdPYLgwFV
=M5g3
-----END PGP SIGNATURE-----
