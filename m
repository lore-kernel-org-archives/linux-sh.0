From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 05 Apr 2013 20:48:01 +0000
Subject: Re: [PATCH 2/8] ehci-platform: add init() method to platform data
Message-Id: <515F3881.1090506@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304050259.51025.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304050259.51025.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/06/2013 12:40 AM, Sergei Shtylyov wrote:

>
>> And instead of passing hcd->regs, wouldn't it be better to pass hcd?
>
>    I really don't know.
>
>> Other users of this interface might need to initialize something other
>> than a non-standard register.
>
>    Hm, maybe... if passing 'struct usb_hcd *' would indeed help here. 
> Do you think it's
> worth passing 'struct platform_device *' along with it?

    Probably not as it can be extracted from 'hcd->self.controller'...

WBR, Sergei

