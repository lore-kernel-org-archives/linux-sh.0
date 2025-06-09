Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD143ABC;
	Mon,  9 Jun 2025 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749463523; cv=none; b=hVv2ItOj3b1Kc1ljnQ9EmG0kWRH7t+GQS3iVgGGAV7D8I9/Zyv8cUthwMlP8FgeO/RiXyG1nYdLuKlVfDGwMxT6IZtfrgMs7wqpW5RT0NWSf75ntuWTRQl/w6y8Lv2Re+ItjykZ4mmIrGFsIUuiPxYmtbmbwGIdx6wVKd44aQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749463523; c=relaxed/simple;
	bh=LIaYfTdy4VX2SijSB1fsERZSR/2FSunWOglQaGexf38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ/iIKWS5tue13YnRsOeAfcywbH9hndGxrH+kKTMRyYxvQoc/hWmJfC+VBjY5Yy0ertGtMMoiTwGn+TNofVgxxXgu5YHmxN2Tuld+H3nn+TQh9ItrT1n09vT+wF67YMlYsLtRL0FyrxBvp7A7Kun4HrTjl1IGIjQ1L9m/15XhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cL1OvQ+7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cL1OvQ+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1749463518;
	bh=LIaYfTdy4VX2SijSB1fsERZSR/2FSunWOglQaGexf38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cL1OvQ+7LsfOUWE3rHXhvHPEooM2uTSuf9JmQZBP4cMkLtVfP5lxnRYlps6BLkWpy
	 UZNls2o1oZoFErLIvQnIjlSfRjLhtg+obZx/kPsuFWK/qlxy8IB1b5O7+jkXYhLHew
	 21zgt0otmTBl/5DHfU9yKpOcmjRhLWdpmAQpNP7w=
Date: Mon, 9 Jun 2025 12:05:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 0/3] tools/nolibc: add support for SuperH
Message-ID: <66678d81-b1ac-48de-be82-1c82ca1c3e31@t-8ch.de>
References: <20250609-nolibc-sh-v1-0-9dcdb1b66bb5@weissschuh.net>
 <0bd3da32be2d82f8ee6f6a544d9d8f8b48b02cd0.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bd3da32be2d82f8ee6f6a544d9d8f8b48b02cd0.camel@physik.fu-berlin.de>

Hi Adrian,

On 2025-06-09 11:53:25+0200, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-06-09 at 11:28 +0200, Thomas Weißschuh wrote:
> > Add support for SuperH/"sh" to nolibc.
> > Only sh4 is tested for now.
> > 
> > This is only tested on QEMU so far.
> > Additional testing would be very welcome.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Thomas Weißschuh (3):
> >       selftests/nolibc: fix EXTRACONFIG variables ordering
> >       selftests/nolibc: use file driver for QEMU serial
> >       tools/nolibc: add support for SuperH
> > 
> >  tools/include/nolibc/arch-sh.h              | 162 ++++++++++++++++++++++++++++
> >  tools/include/nolibc/arch.h                 |   2 +
> >  tools/testing/selftests/nolibc/Makefile     |  15 ++-
> >  tools/testing/selftests/nolibc/run-tests.sh |   3 +-
> >  4 files changed, 177 insertions(+), 5 deletions(-)
> > ---
> > base-commit: 6275a61db2f0586b8a5d651dfc7b4aacf9d0b2d6
> > change-id: 20250528-nolibc-sh-8b4e3bb8efcb
> 
> I have no experience with the selftest code but I can definitely test
> on real hardware if you can point me to some instructions on how to
> run the tests.

That would be much appreciated.
You can compile the selftests like this:

$ cd tools/testing/selftests/nolibc
$ make [CC= CFLAGS_EXTRA=] nolibc-test
$ ./nolibc-test

The test executable is fully self-contained, you can also cross-compile
it and copy it around.


Thomas
