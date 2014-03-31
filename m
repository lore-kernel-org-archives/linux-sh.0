From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 31 Mar 2014 21:23:50 +0000
Subject: Re: [PATCH 1/9] pci-rcar-gen2: add devicetree support
Message-Id: <5339DCE6.70505@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-2-git-send-email-ben.dooks@codethink.co.uk> <5318BCAE.7000108@codethink.co.uk> <53386C2F.1090508@cogentembedded.com> <53386E9D.70803@codethink.co.uk> <53386FE1.5000002@cogentembedded.com> <53387336.2000306@codethink.co.uk>
In-Reply-To: <53387336.2000306@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@lists.codethink.co.uk, magnus.damn@opensource.se, horms@verge.net.au, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org

Hello.

On 03/30/2014 11:40 PM, Ben Dooks wrote:

>>>>>> Add OF match table for pci-rcar-gen2 driver for device tree support.
>>>> [...]

>>>>>> diff --git a/drivers/pci/host/pci-rcar-gen2.c
>>>>>> b/drivers/pci/host/pci-rcar-gen2.c
>>>>>> index fd3e3ab..1216784 100644
>>>>>> --- a/drivers/pci/host/pci-rcar-gen2.c
>>>>>> +++ b/drivers/pci/host/pci-rcar-gen2.c
>>>>>> @@ -16,6 +16,7 @@
>>>>>>   #include <linux/kernel.h>
>>>>>>   #include <linux/module.h>
>>>>>>   #include <linux/pci.h>
>>>>>> +#include <linux/of_pci.h>
>>>>>>   #include <linux/platform_device.h>
>>>>>>   #include <linux/pm_runtime.h>
>>>>>>   #include <linux/sizes.h>

>>>>> Apologies all, there's a missing include of <linux/of.h> which should
>>>>> have been added here

>>>>     Have you ever re-posted this patch fixed? If not, it's not going to
>>>> be merged for 3.15 I guess...

>>> I thought I did.

>>     I don't see such repost in 'linux-sh'.

>>> I can have a look a reposting it.

>>     It doesn't apply to the current renesas.git devel branch. What tree
>> it was against?

>  From my records it was against the -rc3 release of Horms' development
> tree. I know Simon's tree has been closed for the board bits, but I
> could re-send the rcar-pci code.

    Could you address my comments and re-send? Or if you don't have time, 
would you mind that I take this patch into my hands?

WBR, Sergei

