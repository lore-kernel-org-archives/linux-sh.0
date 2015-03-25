From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Mar 2015 04:42:29 +0000
Subject: Re: Can't mount QSPI-FLASH to userland on Lager
Message-Id: <20150325044229.GE28997@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pY3vCvL1qV+PayAL"
List-Id: <linux-sh.vger.kernel.org>
References: <550F6E10.8010907@jinso.co.jp>
In-Reply-To: <550F6E10.8010907@jinso.co.jp>
To: linux-sh@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 10:14:54AM +0900, Cao Minh Hiep wrote:

> The file1 and file2 are logs after enabling Kernel Function Tracer and Trace
> syscalls
> ...debug/tracing/events/spi/enable is not showed in default config.
> Could you please tell me the correct way to get ftrace logs?

After you enable the tracing you can extract the logging that got turned
on from /sys/kernel/debug/tracing/trace.

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEjyuAAoJECTWi3JdVIfQy00H/2VsVU5SKlh81czcz+WrrvPP
a3KHR0swUFTSTc0lEWzebmXPSUGREame5B81lwx2sp/Ncro6NX5Nc4kkfbtNF5aG
lFscqRfZ0zFYRBnI7WwpCgOwL/YDSMsWidfaVRfvC0LFFWrHmCNindMPf3pCg3oO
mSQtA1sZ6ZReFRv2flGcj05nXAXTCQu//UE+Bdp5TxR9fD4ZzzuoNo6ubS+KxwEa
400sj8vxEVbykZ26qqZmqL2jwyc/nP9TyP9UGyWGvXRGcgBDmgFSkL5ZG75/onxp
OOZtX1LiEsJuxk91jB2oftQFJohrtcefmW9FQSwqwQaJyKo3wdMHwdqd+clF/sM=
=lITq
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
