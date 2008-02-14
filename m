From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Date: Thu, 14 Feb 2008 19:39:28 +0000
Subject: Re: ioremap() on SH
Message-Id: <47B498F0.7010904@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
In-Reply-To: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> 0xa000000 is the P2 base, which is the uncached start. In this case
> PXSEG(0xa0000000) = 0xa0000000, so it depends on what you specify as the
> ioremap flags. If you want a cacheable mapping, you will get back
> 0x80000000 which is the cached equivalent of that address. If you want it
> uncached, you will get back 0xa0000000. 0x80000000 and 0xa0000000 point
> at exactly the same thing, just with different caching attributes.
> 

Do you think that such mapping is correct ?

That is to access a device at 0xa000 0000 (physical address), I can use
the virtual address 0xa000 0000 or 0x8000 0000 ?

In this case shouldn't we use the TLB instead to access the device ?
IOW shouldn't ioremap() return a virtual address in P3 segment ?

Thanks
		Franck
