From: Zoltan HERPAI <wigyori@uid0.hu>
Date: Wed, 17 Oct 2012 08:20:52 +0000
Subject: Re: SH kernel boot up issue
Message-Id: <alpine.DEB.2.00.1210171019190.562@trabant.uid0.hu>
List-Id: <linux-sh.vger.kernel.org>
References: <507D5FD5.4050501@gcs-vn.com>
In-Reply-To: <507D5FD5.4050501@gcs-vn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Could this be affecting 7751 as well? I have a board which reboots 
in a couple seconds after the kernel is loaded in. 2.6.22 booted fine on 
that one, but with a recent kernel it's just looping in reboots.

Thanks,
-w-

On Wed, 17 Oct 2012, Hieu Trung Le wrote:

> Mike,
>
> Do you have the bug ID for your issue?
>
> Thanks,
> -Hieu
>
> Think environment!
>
> On 10/17/2012 12:54 PM, Mike Frysinger wrote:
>> On Wednesday 17 October 2012 01:01:18 Tung Pham wrote:
>>> I'm working on custom board that uses sh-7710 cpu, and I tried to boot
>>> with kernel version 2.6.35.13.
>>>
>>> Do you have any idea for this?
>>> BTW: last kernel worked : 2.6.15
>>
>> can you try 2.6.30 and 2.6.31 ?  your crash sounds like a PCI/DMA error i
>> reported w/7750 that shows up starting with 2.6.31.
>> -mike
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
