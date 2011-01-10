From: Pawel Moll <mail@pawelmoll.com>
Date: Mon, 10 Jan 2011 10:10:19 +0000
Subject: Re: [PATCH] mmc, ARM: Add zboot from MMC support for SuperH Mobile
Message-Id: <c1e9db480d82d1804930ddcc7bb0db02@rootnode.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20110109124928.GC25591@verge.net.au>
	<1294589548.8897.1.camel@rojo> <20110109225042.GB29257@verge.net.au>
In-Reply-To: <20110109225042.GB29257@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

 On Mon, 10 Jan 2011 07:50:42 +0900, Simon Horman <horms@verge.net.au>=20
 wrote:
>> >  Documentation/arm/SH-Mobile/Makefile              |    8 +
>> >  Documentation/arm/SH-Mobile/vrl4.c                |  169=20
>> +++++++++++++++++++++
>> How about putting those two into "tools" (in particular "tools/arm")
>> instead of "Documentation"?
>> Just a thought... ;-)
>
> Thats fine by me except that tools/arm doesn't exist yet.
> It would be good to get some consensus before creating it.

 I think there is consensus regarding "tools" as a place for user-space=20
 tools - eg. perf tools used to live in "Documentation/..." and then were=20
 moved to "tools/perf".

 Now, whether your stuff should be in "tools/SH-Mobile" or=20
 "tools/arm/SH-Mobile", I have no opinion ;-)

 Cheers!

 Pawe=C5=82

