From: David Brownell <david-b@pacbell.net>
Date: Tue, 22 Jan 2008 05:26:32 +0000
Subject: Re: [spi-devel-general] [PATCH] spi: add support for SPI over SuperH SCI pins
Message-Id: <200801212126.32727.david-b@pacbell.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
	<20080122031114.GA2062@linux-sh.org>
	<200801212022.23139.david-b@pacbell.net>
In-Reply-To: <200801212022.23139.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Monday 21 January 2008, David Brownell wrote:
> then it's not bad. =A0And it's twice as fast as going through
> a subroutine call for each bitop. =A0That's easily visible on

Minor clarification:  twice as fast for loads involving lots
of medium-size buffers (1K+).  Down from one minute(!) to put
new kernels to the only place that they can boot from ... it's
the usual case where a 5x speedup at one place is very visible,
but doesn't add up to 5x overall; other issues start to show
up more (like unchanged per-byte overheads).

- Dave
