From: Stuart MENEFY <stuart.menefy@st.com>
Date: Fri, 15 Feb 2008 13:15:48 +0000
Subject: Re: ioremap() on SH
Message-Id: <47B59084.2030309@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
In-Reply-To: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Franck Bui-Huu wrote:
> Paul Mundt wrote:
>> 0xa000000 is the P2 base, which is the uncached start. In this case
>> PXSEG(0xa0000000) = 0xa0000000, so it depends on what you specify as the
>> ioremap flags. If you want a cacheable mapping, you will get back
>> 0x80000000 which is the cached equivalent of that address. If you want it
>> uncached, you will get back 0xa0000000. 0x80000000 and 0xa0000000 point
>> at exactly the same thing, just with different caching attributes.
>>
> 
> Do you think that such mapping is correct ?
> 
> That is to access a device at 0xa000 0000 (physical address), I can use
> the virtual address 0xa000 0000 or 0x8000 0000 ?

0xa000 0000 is not a 'correct' physical address in 29 bit mode. In this
example you should really be using physical 0. However traditionally
the SH kernel allowed this because in 29 bit mode it is not ambiguous.

In 32 bit mode this all changes. 0xa000 0000 is now a legitimate physical
address, and needs to be mapped using the TLB or PMB. The current
git kernel doesn't support ioremap for these addresses.

Stuart
