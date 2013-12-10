From: Valentine <valentine.barshak@cogentembedded.com>
Date: Tue, 10 Dec 2013 16:16:02 +0000
Subject: Re: [PATCH 0/2] pinctrl: sh-pfc: pfc-r8a7790: Update VIN groups
Message-Id: <52A73E42.1080604@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386690611-2014-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386690611-2014-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/10/2013 07:57 PM, Laurent Pinchart wrote:
> Hi Valentine,
>
> Thank you for the patches.
>
> On Tuesday 10 December 2013 19:50:09 Valentine Barshak wrote:
>> This adds missing VIN pins to the pfc-r8a7790 driver and reorganizes
>> the VIN groups to cover all possible configurations of VIN data pins.
>> This also groups hsync and vsync pins together and renames "field_signal"
>> and "data_enable" groups to "field" and "clkenb" respectively.
>>
>> Valentine Barshak (2):
>>    pinctrl: sh-pfc: pfc-r8a7790: Add full VIN1/2/3 support
>>    pinctrl: sh-pfc: pfc-r8a7790: Reorganize and rename VIN pin groups
>
>  From a review point of view it would make my life much easier if you could
> switch the patches order. The reason is that patch 2/2 is currently pretty big
> because 1/2 comes first. Inverting them would make the reorganization patch
> simpler, and would make the VIN1/2/3 support patch cleaner.

Current layout splits pin addition and reorganization in 2 completely
separate steps.

Inverting will involve complete rework of the patches.
The reorganization patch would still be pretty big and it would have
to partially include VIN1-related changes from "Add full VIN1/2/3 support"
since some VIN1 pins are missing.

I'll probably try to switch and split them into more patches then.

>
>>   drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 441 +++++++++++++++++++++++++++-----
>>   1 file changed, 382 insertions(+), 59 deletions(-)
>

Thanks,
Val.
