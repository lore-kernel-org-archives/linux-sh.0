From: Andrew Stubbs <ams@codesourcery.com>
Date: Wed, 14 Apr 2010 07:30:51 +0000
Subject: Re: Hi Andrew
Message-Id: <4BC56F2B.1000207@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004140908.16136.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004140908.16136.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 14/04/10 08:08, Fabio Giovagnini wrote:
> Ok. so the Makefile for zImage needs to be modified to use the libc functions
> embedded into the kernel source tree. Is it right?
> If yes, how is it possible to have a general coccect behaviour?

I'm sorry, I'm not sure I understand the question.

Yes, the makefile needs to be modified to remove the dependency on 
libgcc. This was done for the kernel itself a few versions ago. It means 
that the toolchain does not need any special configuration to build the 
kernel, in cases like this where the usermode compiler is incompatible 
with the kernel.

If you're asking how to do the modification, I don't know. I'm not a 
kernel hacker.

If you're asking how any hypothetical project should handle this, then 
the answer is that they should rely on the toolchain, and not have to 
worry about it. The kernel is special - it is traditionally compiled 
with a toolchain unsuitable for building bare-metal programs. It is 
desirable that the same compiler is used for user mode, and for the 
kernel, because having a whole separate toolchain would be a lot of 
wasted effort, but it means that the kernel makefiles have to work hard 
to reconfigure the tools using custom parameters, linker scripts and 
overriding compiler built-ins.

Is that the answer to the question you were asking?

Andrew
