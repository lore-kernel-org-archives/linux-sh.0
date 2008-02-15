From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Date: Fri, 15 Feb 2008 21:12:30 +0000
Subject: Re: ioremap() on SH
Message-Id: <47B6003E.6090000@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
In-Reply-To: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Stuart MENEFY wrote:
> 0xa000 0000 is not a 'correct' physical address in 29 bit mode. In this
> example you should really be using physical 0. However traditionally
> the SH kernel allowed this because in 29 bit mode it is not ambiguous.
> 

Weird: why would a driver use 0xa000 0000 when it can simply use 0 ?
Isn't this error prone ?

Current implementation assumes that if the passed physical address is
greater than 0xc000 0000 then it uses page tables.

Why the 0xc000 0000 limit has been chosen ? Why not simply using the
512M limit ?

> In 32 bit mode this all changes. 0xa000 0000 is now a legitimate physical
> address, and needs to be mapped using the TLB or PMB. The current
> git kernel doesn't support ioremap for these addresses.
> 

Well if you just chose the 512M boundary it works for both world, this
is what I tried to propose in my previous email. And it removes the weid
test "PXSEG(phys) < P3SEG" too.

But I'm probably missing something since I'm not familiar with the SH
world.

		Franck
