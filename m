From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Feb 2008 17:09:15 +0000
Subject: Re: ioremap() on SH
Message-Id: <20080214170915.GA17023@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
In-Reply-To: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2008 at 05:42:32PM +0100, Franck Bui-Huu wrote:
> On Thu 14/02 23:57, Paul Mundt wrote:
> > On Thu, Feb 14, 2008 at 03:36:31PM +0100, Franck Bui-Huu wrote:
> > In 29-bit physical mode, there is no real differentiation. P1 and P2 are
> > both non-translatable sections that refer to the low 512M (P1 is cached,
> > and P2 is uncached). If you're using the MIPS terminology, these are
> > KSEG0 and KSEG1 respectively. In the nommu context the logic is
> > simplified since we don't really have that sort of segmentation, so
> > there's still a direct 1:1 correlation between physical and virtual there
> > also. Thus, we can take a P2 address with a cached remap and hand back
> > the P1 equivalent, and vice versa for cached->uncached transitions.
> 
> What does PXSEG(offset) mean if 'offset' is a physical address ?
> 
> From my understanding this macro used to retreive a *virtual* address
> segment from a *virtual* address. However PXSEG(offset) retrieves the
> *virtual* address segment from a *physical* address which seems a no
> sense.
> 
You've apparently neglected the importance of the term "non-translatable"
as was mentioned above. There is a 1:1 correlation here in the low-512MB.
P1 and P2 are _fixed_, you only have virtual<->physical translations in
P3/P0(U0), and occasionally P4. Otherwise it is only the cacheability of
the mapping that matters, which is determined by whether you access it as
a P1 or P2 address. As should be apparent, we do not take page faults for
non-translatable areas.

> Why doing the following test "PXSEG(offset) < P3SEG" where P3SEG yields
> to 0xc0000000. If offset is 0xa0000000 for example, assuming that 32 bits
> physical mode exists, what's ioremap returning ?
> 
0xa000000 is the P2 base, which is the uncached start. In this case
PXSEG(0xa0000000) = 0xa0000000, so it depends on what you specify as the
ioremap flags. If you want a cacheable mapping, you will get back
0x80000000 which is the cached equivalent of that address. If you want it
uncached, you will get back 0xa0000000. 0x80000000 and 0xa0000000 point
at exactly the same thing, just with different caching attributes.

If you wanted to do a dumb ioremap that assumed you always wanted
uncached and didn't try to deal with the special cases where we need page
table mappings, your ioremap would just be a wrapper to P2SEGADDR, and
this is in fact what we used to have.
