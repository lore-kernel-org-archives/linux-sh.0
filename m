From: phil.edworthy@renesas.com
Date: Mon, 02 Apr 2012 13:08:52 +0000
Subject: Re: iomap API and big endian interactivity
Message-Id: <OF48852917.666E6520-ON802579D4.00482CB4-802579D4.0048384B@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120329074038.GZ26543@linux-sh.org>
In-Reply-To: <20120329074038.GZ26543@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

> On Wed, Oct 12, 2011 at 09:03:24AM +0100, Phil Edworthy wrote:
> > Commit 37b7a97884ba64bf7d403351ac2a9476ab4f1bba makes all 
ioread/iowrite
> > functions treat registers as little endian. For SH2 this is not the 
case,
> > they are big endian.
> > 
> Ok, it looks like we're finally going to have to bite the bullet and
> support I/O swabbing for the platforms that need it. I dislike this for
> the reasons that the I/O accessors are supposed to be little endian and
> in the PCI case we can deal with CPU vs host controller endianness
> mismatches just fine, ensuring a consistent little endian space.
...> 
> Hopefully this will be all that's necessary for fixing up the SH-2(A) 
and
> SH-4A big endian use cases. Boards can of course override the swabbing
> behaviour where necessary, though I don't forsee much need to deviate
> from the generic implementation any time soon given that we've ripped 
out
> the address swizzling (in which case we could probably just inline it in
> io.h directly).

Works for me on sh7264 (sh2a).

Would you like me to add SWAP_IO_SPACE to all the sh2 defconfigs?

One minor comment, this option won't show up in a config menu. Is that ok
for devices that can be used as either big or little endian?

Thanks
Phil

