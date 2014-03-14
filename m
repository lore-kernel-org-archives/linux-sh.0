From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 14 Mar 2014 21:13:06 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <53237EEF.9080900@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 03/14/2014 10:19 PM, Ben Dooks wrote:

>>>> It seems the pm_rumtime work queue is causing the device to be suspended
>>>> during initialisation, thus the initialisation may not be able to access
>>>> registers properly. Use pm_runtime_get_sync() and pm_runtime_put_sync()
>>>> to ensure that the pm system does not suspend it during the probe()
>>>> call.

>>> If this work's for Geert then I'll look into updating the header and
>>> sending it to the netdev list.

>>     I keep wondering why I'm seeing no issues in my setup... I don't
>> have drivers/sh/ patch and have CONFIG_PM_RUNTIME=y. Seeing no issues on
>> multiplatform kernels on neither Lager nor Koelsch (however, other
>> platforms are not enabled).

> Without drivers/sh there is no specification to the pm code to do
> anything with the platform or OF devices. This means the clocks are
> not being auto-managed, which in turn means the clock is probably
> being left on from the boot-loader and thus the unit works correctly.

    Yeah, I TFTP-boot over Ether from U-Boot. I wonder how others' setup is 
different from mine.

> Unfortunately, without drivers/sh patched a number of other drivers
> fail to work. This means we need it or something similar in the kernel.

    I wonder how drivers/sh/ came to existence at all. :-) Although there's 
also drivers/parisc/...

> I will spend some time over the weekend moving the code out of the
> drivers/sh to somewhere else so that this does not occur again.

    Thanks for your work. I just wasn't aware of these issues when I ported 
Ether to DT -- it Just Worked (TM).

WBR, Sergei

