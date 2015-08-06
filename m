From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Aug 2015 23:03:41 +0000
Subject: Re: [PATCH 05/13 v4][RFC] arm64: renesas: Add SCIF2 support on r8a7795
Message-Id: <CANqRtoT2Ub4LuFQBNpRORjOPYaG-6Y8P6Y9-PzSyuj36L80OyA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pp30yhby.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pp30yhby.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Aug 6, 2015 at 5:46 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Shimoda-san
>
>> > +    - "renesas,scifa-r8a7795" for R8A7795 (R-Car H3) SCIFA compatible UART.
>> > +    - "renesas,scifb-r8a7795" for R8A7795 (R-Car H3) SCIFB compatible UART.
>>
>> The R8A7795 doesn't have SCIFA and SCIFB.
>> (In other words, it has SCIF and HSCIF.)
>
> Grr !!
> Thank you for pointing it. will fix in v5

Thanks, at the same time can you break out the DT binding patch from
the DTS changes? They most likely go through different trees.

Best,

/ magnus
