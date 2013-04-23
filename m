From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 23 Apr 2013 10:50:07 +0000
Subject: Re: [PATCH 2/2 v7] sudmac: add support for SUDMAC
Message-Id: <5176675F.1000804@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5174FDF3.8060809@renesas.com>
In-Reply-To: <5174FDF3.8060809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

(2013/04/23 15:31), Vinod Koul wrote:
> On Mon, Apr 22, 2013 at 10:08:45PM -0700, Kuninori Morimoto wrote:
< snip >
>> Selecting SH_DMAE_BASE only is not so strange for me,
>> and (as you mentioned F2F), some driver already depends on it.
>> So this SH_DMAE_BASE should be y, and SH_DMAE/SUDMAC should depend
>> on it.
> What I would expect a decent config to do is have the driver symbol slect
> whatever it needs
> 
> something like
> config SH_BASE
> 
> config SH_DMAE
> 
> config SUDMAC
> 	select SH_DMAE
> 	select SH_BASE
> 
> etc, its nice to have simpler config and driver options. Driver selects all that
> it needs :)
> 
> Btw the driver patch looks sane to me. So once you have sorted what you guys
> want here, I think its good for merge. 

Thank you for the comment. I will send new patches soon.

Best regards,
Yoshihiro shimoda

> --
> ~Vinod
>>
>> I guess this is naturally Kconfig for me
>>
>> config SH_DMAE_BASE
>> 	bool xxx
>> 	default y if (SH_MOBLE && SH)
>>
>> config SH_DMAE
>>         xxxx
>> 	depends on SH_DMAE_BASE
>>
>> config SUDMAC
>>         xxxx
>> 	depends on SH_DMAE_BASE
>>
>> BTW, "SH_DMAE" is mismatch naming, I guess "SHDMAC" is better ?
>>
>> Best regards
>> ---
>> Kuninori Morimoto
> 
