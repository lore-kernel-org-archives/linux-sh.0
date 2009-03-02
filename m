From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 02 Mar 2009 06:31:44 +0000
Subject: Re: [PATCH] sh: Update dma-sh api
Message-Id: <29ab51dc0903012231x158ae710q535877a12f67efca@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49A668C4.2020608@renesas.com>
In-Reply-To: <49A668C4.2020608@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Magnus .

2009/2/27 Magnus Damm <magnus.damm@gmail.com>:
> Hi Iwamatsu-san,
>
> On Thu, Feb 26, 2009 at 7:02 PM, Nobuhiro Iwamatsu
> <iwamatsu.nobuhiro@renesas.com> wrote:
>> Add DMA support of new SH CPU and the change of definition.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
>
> Thanks for your work on this. I have one main question and a few
> nitpicking comments on your patch.
>
> Question:
>
> Does this patch build on top of the reworked sh775x, sh7780 and sh7785
> interrupt vectors? The patchset pointed out below modifies the DMAC
> interrupt to only use a single linux interrupt instead of multiple
> with broken masking:
>
> http://patchwork.kernel.org/patch/8592/

I did not consider your patch.
I will read your patch and think.


>
>> --- /dev/null
>> +++ b/arch/sh/include/asm/dma-sh.h
>> @@ -0,0 +1,151 @@
>> +/*
>> + * arch/sh/drivers/dma/dma-sh.h
>
> Header comment mismatch. =)
>
Thanks, I will fixed next version.

Best regards,
 Nobuhiro

-- 
Nobuhiro Iwamatsu
