From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Sat, 31 Jan 2009 08:46:05 +0000
Subject: Re: [PATCH] fix build failure w. gcc-4.3.3
Message-Id: <20090131094605.131706f7@scarran.roarinelk.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20090130102854.GA13640@roarinelk.homelinux.net>
In-Reply-To: <20090130102854.GA13640@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 30 Jan 2009 11:28:54 +0100
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> gcc-4.3.3 likes to have printf() and related functions to have
> at least 2 arguments when the format string is not a constant:
> 
> cc1: warnings being treated as error
> arch/sh/kernel/setup.c: In function 'early_parse_mem':
> arch/sh/kernel/setup.c:111: error: format not a string literal and no format arguments

Please disregard this patch:  turns out that Gentoo applied a patch
which unconditionally enables -Wformat-security and produces this
message.

My Apologies!

Manuel Lauss

