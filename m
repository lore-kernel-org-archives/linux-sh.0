From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 07:54:56 +0000
Subject: Re: [PATCH 04/05] dmaengine: shdma: Introduce include/linux/sh_dma.h
Message-Id: <aec7e5c31003190054x65cc33f9r324fb4843fa24937@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044710.17051.98259.sendpatchset@t400s>
In-Reply-To: <20100319044710.17051.98259.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Mar 19, 2010 at 4:46 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 19 Mar 2010, Magnus Damm wrote:
>> --- 0004/arch/sh/include/asm/dmaengine.h
>> +++ work/arch/sh/include/asm/dmaengine.h =A0 =A0 =A0 =A02010-03-18 23:25=
:04.000000000 +0900
>> @@ -10,12 +10,7 @@
>> =A0#ifndef ASM_DMAENGINE_H
>> =A0#define ASM_DMAENGINE_H
>>
>> -#include <linux/dmaengine.h>
>> -#include <linux/list.h>
>> -
>> -#include <asm/dma-register.h>
>
> include/linux/sh_dma_register.h? (see below)
> I am still not sure it is a good idea to duplicate these from legacy SH
> DMA driver, maybe we could just move them in a
> include/linux/sh_dma_register.h if they are indeed common?

Nah, no point in adding another header file. The legacy driver should
just die and we're not going to do any more development there. So
duplicating them is fine IMO.

> Ok, I might be lazy on a Friday morning, but could you maybe regenerate
> this one with "-M -C --find-copies-harder" or whatever it takes to make
> git use "git rename" for this? This should work if we don't duplicate
> register names, not sure otherwise...

I don't think that will help if we have two copies of the register names.

Thanks for your help!

/ magnus
