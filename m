From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Wed, 21 Oct 2020 06:45:18 +0000
Subject: Re: [PATCH 2/2] dt: Remove booting-without-of.rst
Message-Id: <20201021084518.1eab6481@coco.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <20201008142420.2083861-1-robh@kernel.org>
        <20201008142420.2083861-2-robh@kernel.org>
In-Reply-To: <20201008142420.2083861-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Jonathan Corbet <corbet@lwn.net>, Paul Mackerras <paulus@samba.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hi Rob,

Em Thu,  8 Oct 2020 09:24:20 -0500
Rob Herring <robh@kernel.org> escreveu:

> booting-without-of.rstt is an ancient document that first outlined
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

Removing this document caused a warning at Documentation/arm/booting.rst:

	$ ./scripts/documentation-file-ref-check 
	Documentation/arm/booting.rst: Documentation/devicetree/booting-without-of.rst

as it mentions that the DTB format is described on booting-without-of.rst:

	4b. Setup the device tree
	-------------------------

	The boot loader must load a device tree image (dtb) into system ram
	at a 64bit aligned address and initialize it with the boot data.  The
	dtb format is documented in Documentation/devicetree/booting-without-of.rst.
	The kernel will look for the dtb magic value of 0xd00dfeed at the dtb
	physical address to determine if a dtb has been passed instead of a
	tagged list.

So, I guess that such part of the document needs to be moved to booting.rst.

Thanks,
Mauro
