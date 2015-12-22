From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 22 Dec 2015 11:15:15 +0000
Subject: Re: [PATCH v5] extcon: add Maxim MAX3355 driver
Message-Id: <567930C3.3090600@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5948633.my3nAG6hRz@wasted.cogentembedded.com>
 <CAGTfZH34rfMfjsAFgyPeNue74-5iCi6ZwrdN26_jwOXE6R=hwg@mail.gmail.com>
 <5676E214.2040009@cogentembedded.com> <5677662C.6060409@samsung.com>
 <5677DC21.3040509@cogentembedded.com> <5678A3BE.3040701@samsung.com>
In-Reply-To: <5678A3BE.3040701-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On 12/22/2015 4:13 AM, Chanwoo Choi wrote:

>>>>> This patch depend on GPIOLIB configuration as following:
>>>>> I modified it with following diff and applied it.
>>>>>
>>>>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>>>>> index ba4db7d..3d89e60 100644
>>>>> --- a/drivers/extcon/Kconfig
>>>>> +++ b/drivers/extcon/Kconfig
>>>>> @@ -54,6 +54,7 @@ config EXTCON_MAX14577
>>>>>
>>>>>     config EXTCON_MAX3355
>>>>>            tristate "Maxim MAX3355 USB OTG EXTCON Support"
>>>>> +       depends on GPIOLIB || COMPILE_TEST
>>>>
>>>>      If it won't compile w/o gpiolib, what's the use of COMIPLE_TEST?
>>>>      And no, it shouldn't depend on gpiolib. It has empty stubs for the case of CONFIG_GPIOLIB=n. Obviously something is wrong with the GPIO headers, I'll look into it.
>>>
>>> Yes. When GPIOLIB is disabled, the build issue don't happen.
>>
>>     What? It surely does happen!
>
> hmm....
> Sure. you need to check the include/linux/gpio/consumer.h.
>
> Because of build error happen, you miss to include the "linux/gpio/consumer.h"
> header file in extcon-max3355.c. Please test it for enough time.

    Yes, with this file #include'd, it build fine now.

>>> because include/linux/gpio/consumer.h implement the dummy function
>>> for all gpio functions if CONFIG_GPIOLIB is disabled.
>>
>>     Linus W. advised to #include this header explicitly -- I'll try and post.
>
> Don't necessary. I already updated it including the "include/linux/gpio/consumer.h".

    I saw that, yes.

>>> For correct operation of max3355, you should add the dependency
>>> to the extcon-max3355.c driver. This driver use the GPIO library
>>> certainly.
>>
>>     I disagree. The driver will just cease to load in this case. I don't see why we need such dependency. Only compilation time dependencies should be
>> specified, I think.
>
> This driver have to depend on GPIOLIB.
> Why are you disagreeing the COMPILE_TEST dependency? It is just compile test
> without anything.

    I agree now. I still disagree about the gpiolib dependency though.

MBR, Sergei

