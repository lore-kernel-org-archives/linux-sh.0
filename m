From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sun, 25 Apr 2010 12:30:09 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <4BD435D1.3070000@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Magnus-san, and Alex-san,

Thank you very much for your guides.
Setting "CONFIG_SERIAL_SH_SCI_NR_UARTS=2" solved my problem fully.
I find no qemu crash, and happy to see login prompt again.

I tried out these two option with real R2D+ boards and recent sh-2.6 git.
   CONFIG_SERIAL_SH_SCI_NR_UARTS=1  ... no serial output
   CONFIG_SERIAL_SH_SCI_NR_UARTS=2  ... kernel boot log printed in serial output

I hope the patch applied soon :)

Best Regards,
Shin-ichiro KAWASAKI


(2010/04/21 17:30), Magnus Damm wrote:
> Hey Kawasaki-san,
>
> 2010/4/11 Shin-ichiro KAWASAKI<kawasaki@juno.dti.ne.jp>:
>> Hello Magnus,
>>
>> I'm in trouble with qemu-sh serial console.  Don't you have any
>> guide on this trouble?
>
> Yes, I think the defconfig is missing one thing. Please try setting
> CONFIG_SERIAL_SH_SCI_NR_UARTS=2. See below.
>
>> With the patch, qemu-sh serial console doesn't work.
>> The emulated device is r2d+.
>>
>>   - no earlyprintk option
>>   ... Qemu carshes with assertion. No kernel boot log printed.
>>       I guess it touches sh-sci.0 registers, which qemu doesn't support.
>
> Hm, I'm not sure why this happens. Did you update the kernel command
> line to use ttySC1?
>
> This commit in linux-2.6 git may be useful:
>
>   cd5f107628ab89c5dec5ad923f1c27f4cba41972
>
>>   - earlyprintk=sh-sci.1
>>   ... Qemu boots up with kernel boot log output,
>>       but the log message stops with
>>       "turn off boot console early_ttySC0' message.
>>       No login prompt appears.
>>   - earlyprintk=sh-sci.1,115200,keep
>>   ... The message "turn off boots up ..." disappears, but no
>>       login prompt appears.
>
> I think this is because CONFIG_SERIAL_SH_SCI_NR_UARTS is set to 1. Or
> perhaps is your user space still using ttySC0 instead of ttySC1?
>
> Does updating CONFIG_SERIAL_SH_SCI_NR_UARTS to 2 solve your issue?
>
> Thanks for the report and sorry about the breakage.
>
> / magnus
>

