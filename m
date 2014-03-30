From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 30 Mar 2014 19:10:39 +0000
Subject: Re: [PATCH 1/9] pci-rcar-gen2: add devicetree support
Message-Id: <53386C2F.1090508@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-2-git-send-email-ben.dooks@codethink.co.uk> <5318BCAE.7000108@codethink.co.uk>
In-Reply-To: <5318BCAE.7000108-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, magnus.damn-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On 03/06/2014 09:21 PM, Ben Dooks wrote:

>> Add OF match table for pci-rcar-gen2 driver for device tree support.
[...]

>> diff --git a/drivers/pci/host/pci-rcar-gen2.c
>> b/drivers/pci/host/pci-rcar-gen2.c
>> index fd3e3ab..1216784 100644
>> --- a/drivers/pci/host/pci-rcar-gen2.c
>> +++ b/drivers/pci/host/pci-rcar-gen2.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> +#include <linux/of_pci.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/sizes.h>

> Apologies all, there's a missing include of <linux/of.h> which should
> have been added here

    Have you ever re-posted this patch fixed? If not, it's not going to be 
merged for 3.15 I guess...

WBR, Sergei

