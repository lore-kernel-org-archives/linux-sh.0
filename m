From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Apr 2013 17:27:46 +0000
Subject: Re: [PATCH v2 1/2] ARM: mach-shmobile: r8a7779: Add DU support
Message-Id: <515DB812.5000109@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1364412073-12322-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364412073-12322-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/04/2013 06:54 PM, Laurent Pinchart wrote:

>>>>> Add a function to register the DU device with board-specific platform
>>>>> data.
>>>>>
>>>>> Signed-off-by: Laurent Pinchart
>>>>> <laurent.pinchart+renesas@ideasonboard.com>
[...]
>>>
>>>>> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c
>>>>> b/arch/arm/mach-shmobile/setup-r8a7779.c index a460ba3..2f817d8 100644
>>>>> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
>>>>> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
>>>>> @@ -393,6 +393,29 @@ static struct platform_device sata_device = {
>>>> [...]
>>>>
>>>>> +static struct platform_device du_device = {
>>>>> +	.name		= "rcar-du",
>>>>> +	.num_resources	= ARRAY_SIZE(du_resources),
>>>>> +	.resource	= du_resources,
>>>>> +	.id		= 0,
>>>>>
>>>>       You probably should have written in the subject "add DU0 support".
>> If there's only single display device, why you're not using 'id' of -1?
> Good point. I'll fix that.
>

    Note that the DU clock entry already has "rcar-du.0".

WBR, Sergei

