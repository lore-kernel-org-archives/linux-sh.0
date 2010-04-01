From: Andrew Stubbs <ams@codesourcery.com>
Date: Thu, 01 Apr 2010 07:59:11 +0000
Subject: Re: objdump on libgcc
Message-Id: <4BB4524F.9060706@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004010937.26235.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004010937.26235.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/04/10 08:37, Fabio Giovagnini wrote:
> This is the result,
> so I think libgcc is only for fdpic target, so if I need it for building
> kernel (and for making zImage it seems to be essential) I can link only a
> wrong libgcc.

Absolutely, there is only FDPIC libgcc in the release I sent to you.

The kernel has not needed glibc for a while now. The relevant routines 
were copied/rewritten to arch/sh/lib.

I expect that all the routines you need are present, so it should just 
be makefile adjustments. If it does need something extra (that somehow 
the whole of the rest of the kernel can do without) then I expect it can 
be extracted from the compiler sources (gcc/config/sh/lib1funcs.asm). 
The linker should have already told you this list of routines it needs.

Andrew
