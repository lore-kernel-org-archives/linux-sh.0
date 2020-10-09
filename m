From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 09 Oct 2020 03:51:51 +0000
Subject: Re: [PATCH 2/2] dt: Remove booting-without-of.rst
Message-Id: <87imbk12g8.fsf@mpe.ellerman.id.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20201008142420.2083861-1-robh@kernel.org> <20201008142420.2083861-2-robh@kernel.org>
In-Reply-To: <20201008142420.2083861-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Jonathan Corbet <corbet@lwn.net>, Paul Mackerras <paulus@samba.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Rob Herring <robh@kernel.org> writes:
> booting-without-of.rstt is an ancient document that first outlined
                        ^
                        nit

> Flattened DeviceTree on PowerPC initially. The DT world has evolved a
> lot in the 15 years since and booting-without-of.rst is pretty stale.
> The name of the document itself is confusing if you don't understand the
> evolution from real 'OpenFirmware'. Most of what booting-without-of.rst
> contains is now in the DT specification (which evolved out of the
> ePAPR). The few things that weren't documented in the DT specification
> are now.
>
> All that remains is the boot entry details, so let's move these to arch
> specific documents. The exception is arm which already has the same
> details documented.
>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/booting-without-of.rst         | 1585 -----------------
>  Documentation/devicetree/index.rst            |    1 -
>  Documentation/mips/booting.rst                |   28 +
>  Documentation/mips/index.rst                  |    1 +
>  Documentation/powerpc/booting.rst             |  110 ++

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
