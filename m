From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 30 Mar 2014 19:40:38 +0000
Subject: Re: [PATCH 1/9] pci-rcar-gen2: add devicetree support
Message-Id: <53387336.2000306@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-2-git-send-email-ben.dooks@codethink.co.uk> <5318BCAE.7000108@codethink.co.uk> <53386C2F.1090508@cogentembedded.com> <53386E9D.70803@codethink.co.uk> <53386FE1.5000002@cogentembedded.com>
In-Reply-To: <53386FE1.5000002@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@lists.codethink.co.uk, magnus.damn@opensource.se, horms@verge.net.au, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org

On 30/03/14 20:26, Sergei Shtylyov wrote:
> Hello.
>
> On 03/30/2014 11:21 PM, Ben Dooks wrote:
>
>>>>> Add OF match table for pci-rcar-gen2 driver for device tree support.
>>> [...]
>
>>>>> diff --git a/drivers/pci/host/pci-rcar-gen2.c
>>>>> b/drivers/pci/host/pci-rcar-gen2.c
>>>>> index fd3e3ab..1216784 100644
>>>>> --- a/drivers/pci/host/pci-rcar-gen2.c
>>>>> +++ b/drivers/pci/host/pci-rcar-gen2.c
>>>>> @@ -16,6 +16,7 @@
>>>>>   #include <linux/kernel.h>
>>>>>   #include <linux/module.h>
>>>>>   #include <linux/pci.h>
>>>>> +#include <linux/of_pci.h>
>>>>>   #include <linux/platform_device.h>
>>>>>   #include <linux/pm_runtime.h>
>>>>>   #include <linux/sizes.h>
>
>>>> Apologies all, there's a missing include of <linux/of.h> which should
>>>> have been added here
>
>>>     Have you ever re-posted this patch fixed? If not, it's not going to
>>> be merged for 3.15 I guess...
>
>> I thought I did.
>
>     I don't see such repost in 'linux-sh'.
>
>> I can have a look a reposting it.
>
>     It doesn't apply to the current renesas.git devel branch. What tree
> it was against?

 From my records it was against the -rc3 release of Horms' development
tree. I know Simon's tree has been closed for the board bits, but I
could re-send the rcar-pci code.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
