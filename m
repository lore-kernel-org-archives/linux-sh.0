From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Sep 2015 07:48:00 +0000
Subject: Re: [PATCH v8 05/07] arm64: renesas: r8a7795: enable PFC
Message-Id: <CANqRtoT=TJrt9AGrUN4A91ueSL=cxahwK3qX6XSfwKzsBPWbJg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831063003.24004.42127.sendpatchset@little-apple>
In-Reply-To: <20150831063003.24004.42127.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Aug 31, 2015 at 7:41 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus and Morimoto-san,
>
> Thank you for the patch.
>
> On Monday 31 August 2015 15:30:03 Magnus Damm wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> Add a PFC node for the on-chip r8a7795 pin controller.
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

>> ---
>>
>>  Based on:
>>   [PATCH 10/25 v7][RFC] arm64: renesas: r8a7795: enable PFC
>>
>>  Changes: (Magnus Damm <damm+renesas@opensource.se>)
>>  - Added changelog
>>
>>  TODO:
>>  - Add Kconfig select bits
>
> Do they belong to this patch ?

I think they are
A) related (DTS patch and Kconfig needed for runtime functionality)
B) enabled in the same subsystem (under arch/arm64)

So because of that I feel it makes sense to keep them together. At the
same time, Geert asked me to split the following patch:
[PATCH v8 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support

So based on that both you and Geert prefer to separate the Kconfig
bits then I'll go with that way.

Cheers,

/ magnus
