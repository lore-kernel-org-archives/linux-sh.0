From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Date: Thu, 14 Feb 2008 14:36:31 +0000
Subject: ioremap() on SH
Message-Id: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

I'm puzzled by the implementation of ioremap() on SH architecture.

Here it is:

        if (likely(PXSEG(offset) < P3SEG && PXSEG(last_addr) < P3SEG)) {
                if (unlikely(flags & _PAGE_CACHABLE))
                        return (void __iomem *)P1SEGADDR(offset);

                return (void __iomem *)P2SEGADDR(offset);
        }

        return __ioremap(offset, size, flags);

where 'offset' is a physical address...

If I understand correctly PXSEG(x) is used to get the segment of a
_virtual_ address, so doing PXSEG(offset) looks weird.

Furthermore, it looks like the virtual to physical address translation is
similar to MIPS 32 bits architecture. Therefore only the low 512Mo of the
physical address space can be accessed through P1/P2 segments.

So this test:

        if (likely(PXSEG(offset) < P3SEG && PXSEG(last_addr) < P3SEG)) {

                /* simply map the address into P2 seg */

        }

where P3SEG = 0xc0000000 seems wrong too.

Why not simply doing something like this ?

        if (unlikely(offset >= offset + size))
                return NULL;

        if (offset + size < 0x20000000)
                return (void __iomem *)P2SEGADDR(offset);

        return __ioremap(offset, size, flags);

Thanks

                Franck
