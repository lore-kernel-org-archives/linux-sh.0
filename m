From: Adrian McMenamin <lkmladrian@gmail.com>
Date: Fri, 06 Apr 2012 13:40:45 +0000
Subject: Re: Utility code to generate a VMUFAT filesystem
Message-Id: <CAN628AE6GLEUGke68z0rfbZWvmEuTsBQ0EHcy4mzC6Bz3bYX5Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAN628AHjJeLD_bUNGSDmBOo_EW=aFML-VZ-A4GRyAi2eNwA1yw@mail.gmail.com>
	<201203250232.29843.vapier@gentoo.org>
In-Reply-To: <201203250232.29843.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, Adrian McMenamin <adrianmcmenamin@gmail.com>

On 25 March 2012 14:32, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 21 March 2012 00:41:17 Adrian McMenamin wrote:
>> /*
>>  * mkfs.vmufat.c - make a linux (VMUFAT) filesystem
>>  *
>>  * Copyright (c) 2012 Adrian McMenamin adrianmcmenamin@gmail.com
>>  * Licensed under Version 2 of the GNU General Public Licence
>>  *
>>  * Parts shamelessly copied from other mkfs code
>>  * copyright Linus Torvalds and others


With thanks to Mike - a new version of mkfs.vmufat.c is now available
at https://github.com/mcmenaminadrian/mkfs.vmufat

I have tried to incorporate all his points - even the bits where he
was complaining about the code I lifted from Linus's work :)


Any and all feedback welcome.

Adrian
