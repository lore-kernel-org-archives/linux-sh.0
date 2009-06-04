From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Jun 2009 07:53:54 +0000
Subject: Re: [PATCH] sh: sh7724 clock framework rewrite
Message-Id: <aec7e5c30906040053k4247052fof8ada2fdad482b95@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090602103459.13411.85023.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090602103459.13411.85023.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thanks for checking the patch!

On Wed, Jun 3, 2009 at 2:04 PM, Kuninori Morimoto
<morimoto.kuninori@renesas.com> wrote:
> on new clock-sh7724.c
>
>> +static unsigned long pll_recalc(struct clk *clk)
>> +{
>> + =A0 =A0 return clk->parent->rate * (((__raw_readl(FRQCRA) >> 24) & 0x3=
f) + 1);
>> +}
>
> sh7724 needs "* 2" here.
> please check old clock-sh7722.c

Yes, you are correct. Thanks for finding this problem.

I've fixed this in V2 that I posted yesterday. Let me know if you find
any other issues.

Thanks,

/ magnus
