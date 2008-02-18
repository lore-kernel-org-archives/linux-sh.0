From: Stuart MENEFY <stuart.menefy@st.com>
Date: Mon, 18 Feb 2008 13:44:30 +0000
Subject: Re: ioremap() on SH
Message-Id: <47B98BBE.9030705@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
In-Reply-To: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Franck Bui-Huu wrote:
> Stuart MENEFY wrote:
>> 0xa000 0000 is not a 'correct' physical address in 29 bit mode. In this
>> example you should really be using physical 0. However traditionally
>> the SH kernel allowed this because in 29 bit mode it is not ambiguous.
> 
> Weird: why would a driver use 0xa000 0000 when it can simply use 0 ?
> Isn't this error prone ?

In 29 bit mode the mappings at P1 and P2 are hard wired, so I suspect it
fools people into thinking that the peripherals really are at those
address. In fact in older systems which are only 29 bit, it does work,
because the top three bits don't even exist, and so it doesn't matter what
you set them to.

It also means that people 'forget' to use ioremap at all, and abuse
ctrl_in/out, which is why the switch to 32 bit physical addressing isn't
as painless as it should be.

> Current implementation assumes that if the passed physical address is
> greater than 0xc000 0000 then it uses page tables.
> 
> Why the 0xc000 0000 limit has been chosen ? Why not simply using the
> 512M limit ?
 >
>> In 32 bit mode this all changes. 0xa000 0000 is now a legitimate physical
>> address, and needs to be mapped using the TLB or PMB. The current
>> git kernel doesn't support ioremap for these addresses.
> 
> Well if you just chose the 512M boundary it works for both world, this
> is what I tried to propose in my previous email. And it removes the weid
> test "PXSEG(phys) < P3SEG" too.

Is simply an efficiency issue. In 29 bit mode we don't want to use the page
tables as the P1/P2 mappings do the job just fine, without having to set up
the page tables and take faults.

> But I'm probably missing something since I'm not familiar with the SH
> world.

Unfortunately there is a lot more missing for full 32 bit mode support than
just a working ioremap(). Paul has been kindly picking up some of the changes
from the ST tree, but there is still a sizeable chunk to come, and we
have to work out what needs changing for the Renesas parts. In the ST tree,
in 29 bit mode, remapping anything between 0x2000 0000 (end of 29 bit physical)
and 0xdfff ffff (top of P3) is an error, in an attempt to remove this type of
abuse by driver writers!

Stuart

