From: Chanwoo Choi <cw00.choi@samsung.com>
Date: Thu, 11 Dec 2014 12:51:54 +0000
Subject: Re: [PATCH] extcon: add MAX3355 driver
Message-Id: <5489936A.3010409@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <14631865.01KLlU2iKL@wasted.cogentembedded.com>
 <5488F775.1030304@samsung.com> <54899264.30009@cogentembedded.com>
In-Reply-To: <54899264.30009-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/11/2014 09:47 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/11/2014 4:46 AM, Chanwoo Choi wrote:
> 
>> I reviewed this patch quickly. This driver has just two gpio without any registers for IP.
> 
>    Because there are no registers.
> 
>> I wonder whether MAX3355E is separate chip to detect external connector
> 
>    Yes. I thought my description has made that clear...
> 
>> or just use gpio of AP.
> 
>    What do you mean by AP?
>    MAX3355 is indeed partly connected to GPIOs and partly to the USB pins.
> 
>> Could you send the datasheet of MAX3355E to me?
> 
>    Looks like Geert has beaten me to it. :-)
> 
>> Thanks,
>> Chanwoo Choi
> 

OK, I'll review it.

Thanks,
Chanwoo Choi

