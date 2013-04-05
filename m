From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 05 Apr 2013 20:59:10 +0000
Subject: Re: [PATCH 2/8] ehci-platform: add init() method to platform data
Message-Id: <515F3B1E.40402@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304050259.51025.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304050259.51025.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/06/2013 12:56 AM, Alan Stern wrote:

>>>> And instead of passing hcd->regs, wouldn't it be better to pass hcd?
>>>     I really don't know.
>>>
>>>> Other users of this interface might need to initialize something other
>>>> than a non-standard register.
>>>     Hm, maybe... if passing 'struct usb_hcd *' would indeed help here.
>>> Do you think it's
>>> worth passing 'struct platform_device *' along with it?
>>      Probably not as it can be extracted from 'hcd->self.controller'...
> It's up to you.  Generally I think it's easier to pass an extra
> argument than to force the function being called to dig it out.

    Note that in our use case we don't even need this argument.

> Alan Stern

WBR, Sergei

