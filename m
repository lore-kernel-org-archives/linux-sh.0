From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 29 Apr 2014 07:21:43 +0000
Subject: Re: [PATCH v4 05/11] ARM: shmobile: r7s72100: genmai: add uart aliases and activate scif2 as console
Message-Id: <20140429072143.GA2732@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
List-Id: <linux-sh.vger.kernel.org>
References: <1398704521-23767-1-git-send-email-wsa@the-dreams.de>
 <1398704521-23767-6-git-send-email-wsa@the-dreams.de>
 <CANqRtoTHy+-ac0kWY5a9MdYN0=jwWdeuOus9CVBckmas32_hSQ@mail.gmail.com>
In-Reply-To: <CANqRtoTHy+-ac0kWY5a9MdYN0=jwWdeuOus9CVBckmas32_hSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Magnus,

> Thanks for your updated series. For this patch I only have a minor
> comment. I believe we only want to enable the serial port that is used
> on the board. At the same time we want to keep the same ordering as
> the legacy code. I believe you keep the same order already and only
> enable ttySC2, but I wonder if you really need all the aliases above?
> Perhaps it is possible to keep just serial2?

Yeah, this is easily possible. I wanted to add the additional aliases
because the other SCIF pins are available on the external connectors and
wanted potential users to save some hassle. Let me know if you think
this is not needed and I will resend this patch only taking care of
SCIF2.

Thanks,

   Wolfram


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTX1MHAAoJEBQN5MwUoCm2CxgQALDpbpYvBzuWIYd5mIJDzRC5
36R7rXj6ztlYYwQXcw4rnGqhzXdBq21+e/+1ULrtg4+ciO15FEQ7ip4zMAA47U+m
CB3pvSNIjWPSDro13huIZVrbH7L5qVy6TvLabXDDB0bDqOauIZGwb8d1MqBPe8gn
MUZq3F9rozSW3ZLi4CdJdifVeIBWRWUe8fRnetQWHHFYCXXHyIKtrWDdME5YDRFM
mj/mxIIVkPGnX3vFFsWT4Y06VHbAs6tDKOtgFbvLffIHhJmJfdcCp6kS1qw3lV5o
Bu/bh/H4JXkTabX7vuQ8aGD+gudbsaKTMTrMRWySSUx0bZ4CbBQj0LQF40VtJFiG
PbzA9IOVbgjGMCnDuHfi2JkN1oA6u/ArBMmbUea4GzawlCQaJMSbMueT8fXuJ9sd
DRElvkl4usGIwV+KXBthmCf/c24mJ3M+VXUCFUbyW9Olrd6aTLOe00DcDZ/LnW8U
GXZAKR4bIP/wZos/ahyBtd6N10OGQNvkf0bwZZqqS1NN9mvCW7Dm4s9sNv57hOuL
FIgtc6XHZ7uEUgVoQswHZkl8yZR+fsC+LGFbnbA5lnj56xpeunrot320UyIA31Xp
UNdSCkVerwwJScUkiRAN6FDeRRKGUNavSt5OVmJtyjbuwb0cBaIoMY/jDzfik5mS
ezGMqikKLvbQEHZGEund
=/v5p
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
