From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jun 2009 08:04:49 +0000
Subject: Re: [PATCH] sh: sh7724 clock framework rewrite V2
Message-Id: <aec7e5c30906090104o59d61ef6j64e7da900fdb9026@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090602103459.13411.85023.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090602103459.13411.85023.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thanks for checking the patch.

On Mon, Jun 8, 2009 at 7:03 PM, Kuninori
Morimoto<morimoto.kuninori@renesas.com> wrote:
>> This patch contains V2 of the sh7724 clock framework
>> rewrite. The new code makes use of the recently merged
>> div4, div6 and mstp32 helper code. Both extal and fll are
>> supported as input clocks to the pll. The div6 clocks are
>> fed through a divide-by-3 block.
>
>> - =A0 =A0 MSTPCR("tmu1", "peripheral_clk", 0, 10, 0),
> (snip)
>> + =A0 =A0 MSTP("flctl0", &div4_clks[DIV4_P], MSTPCR0, 10, 0, 1, 0),

Yeah, you are correct.

> I wonder your manual is old one.
> old manual is very bad, and it say lie sometimes.
>
> correct MSTP010 is "tmu1" here

I used the Japanese version of Rev 0.10 for this code, but it contains
"tmu1" for MSTP010.
So this must be my typo. Sorry about that.

I'll repost V3 in the near future. Thank you!

/ magnus
