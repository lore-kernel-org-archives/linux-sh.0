From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 08:15:42 +0000
Subject: Re: [PATCH 05/05] dmaengine: shdma: Enable on SH-Mobile ARM
Message-Id: <aec7e5c31003190115v7da0f1d5h86967fd4b4177b2a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044719.17051.57155.sendpatchset@t400s>
In-Reply-To: <20100319044719.17051.57155.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hey Guennadi,

On Fri, Mar 19, 2010 at 4:24 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 19 Mar 2010, Magnus Damm wrote:
>> --- 0005/include/linux/serial_sci.h
>> +++ work/include/linux/serial_sci.h =A0 2010-03-18 23:38:59.000000000 +0=
900
>> @@ -3,7 +3,7 @@
>>
>> =A0#include <linux/serial_core.h>
>> =A0#ifdef CONFIG_SERIAL_SH_SCI_DMA
>> -#include <asm/dmaengine.h>
>> +#include <linux/sh_dma.h>
>
> Shouldn't this be done in patch "04/05"?

It could, but nothing requires this change in 04/05. So the final
point where this is needed is 05/05.

/ magnus
