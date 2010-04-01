From: Andrew Stubbs <ams@codesourcery.com>
Date: Thu, 01 Apr 2010 07:36:13 +0000
Subject: Re: Sourcery G++ 4.4-136 Release
Message-Id: <4BB44CED.3020507@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003271507.12509.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003271507.12509.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/04/10 08:19, Fabio Giovagnini wrote:
> Hi Andrew, what are
> sh-uclinux-ld: Warning: size of symbol `sys_connect' changed from 12 in
> kernel/built-in.o to 164 in net/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_socketpair' changed from 12 in
> kernel/built-in.o to 312 in net/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_getpeername' changed from 12 in
> kernel/built-in.o to 164 in net/built-in.o

This means that some of the COMDAT sections did not match exactly when 
the linker tried to unify them.

Basically, both the files have a copy of what is supposedly the exact 
same code. The linker then chooses one, it doesn't matter which, and 
discards the others. However, the linker first does a few sanity checks 
to make sure they are the same, and in this case it has found that they 
are not.

This can be caused in one of two ways:

1. The sections were compiled from different source code (with the same 
name). This is a user mistake and results in undefined behaviour.

2. The same source was compiled with different optimization and/or other 
compiler parameters. This is typically harmless.

The problem might be a latent bug in the kernel build system, or it 
might be a toolchain bug. I don't know yet.

Either way, my kernel built with many of those warnings, but it seems to 
run fine.

Andrew
