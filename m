From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Thu, 02 Oct 2014 23:14:48 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: switch from scif to scifa
Message-Id: <542DDC68.80704@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram, Simon,

Though the patch was already queued up by Simon,
I'd like to confirm one point in changelog.

On 10/2/2014 9:12 AM, Simon Horman wrote:
[snip]
>>>>>>>>>> On Tuesday 16 September 2014 18:10:37 Wolfram Sang wrote:
>>>>>>>>>>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>>>>>>>>>
>>>>>>>>>>> SCIF and SCIFA can be plexed onto the same wires on Lager board.
>>>>>>>>>>> The datasheet also describes the wires as SCIFA. So, to make use
>>>>>>>>>>> of the bigger FIFOs switch to SCIFA instead.

Which datasheet you are mentioned about ?
I checked Lager board datasheet rev0.09 and it said debug interface is SCIF0 and SCIF1.

[snip]
>>>>>>>>>>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[snip]
>>>>>>>>>>> Currently, I use this patch to check if the DMA RX issue is the
>>>>>>>>>>> same on SCIF and SCIFA (yes, it is). However, I still think it
>>>>>>>>>>> makes sense to use the bigger FIFOs. I will check this next week
>>>>>>>>>>> with Bastian's FIFO patches. Until then, I send this as RFC to
>>>>>>>>>>> collect opinions speaking for/against this change.

[snip]
>>>>>>>>>> I have nothing against this change, but I believe the aliases should
>>>>>>>>>> now be serial0 and serial1 to match the legacy code (OK, that's a
>>>>>>>>>> lame excuse, we all know that I just want to change the aliases
>>>>>>>>>> ;-)).

[snip]
>>>>> This patch switches the Lager board to use SCIFA[01] instead of SCIF[01],
>>>>> while keeping the Linux devices named /dev/ttySC[67]. With legacy boot,
>>>>> SCIFA[01] are named /dev/ttySC[01]. There would thus be a mismatch in that
>>>>> sense, even if this change doesn't prevent using the same Linux serial
>>>>> devices on both legacy and DT boot.

[snip]
>>>> So if I understand if correctly, booting with the current
>>>> "console=ttySC6,115200"
>>>> in /chosen/bootargs will give a working console for both legacy and
>>>> multi-platform,
>>>> but the underlying serial hardware block for the console differs (legacy
>>>> uses SCIF0, multi-platform uses SCIFA0)?

[snip]
>> I will confer with Magnus as he has had strong opinions in this area
>> in the past.

[snip] 
> Magnus also seems happy with this change so I have queued it up.

-- 
Best regards,
KHIEM Nguyen
