From: Andrew Stubbs <ams@codesourcery.com>
Date: Mon, 22 Mar 2010 10:28:52 +0000
Subject: Re: QUESTION- Codesurgery toolchain is usable  for userspace app
Message-Id: <4BA74664.10300@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003212156.52888.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003212156.52888.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

>>> I have used codesurgery lite 4.4-43 and  I can build the kernel
>>> and boot it successfully.

>>> Can I use teh same toolchain for building an userspace
>>> application using uclibc? Is it necessary I link that application
>>> as BFLT (using elf2flt) or not?

...

> Sorry for the error; I'lll be more carefull in the future. The
> question is: my cpu is sh2a 7203; it has not MMU; in this condition,
> or building an userspace application do I need to link use elf2flt;
> or the use spece allpication will work also if I like using
> sh-linnux-gnu-ld without passing trought elf2flt?

The 4.4-43 toolchain is for SH-4A only. It can build the SH-2A kernel 
(but only after a certain kernel version), but cannot build SH-2A user 
applications - it does not have to correct multilibs.

Andrew
