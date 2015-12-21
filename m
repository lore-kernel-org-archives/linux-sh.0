From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 21 Dec 2015 11:01:53 +0000
Subject: Re: [PATCH v5] extcon: add Maxim MAX3355 driver
Message-Id: <5677DC21.3040509@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5948633.my3nAG6hRz@wasted.cogentembedded.com>
 <CAGTfZH34rfMfjsAFgyPeNue74-5iCi6ZwrdN26_jwOXE6R=hwg@mail.gmail.com>
 <5676E214.2040009@cogentembedded.com> <5677662C.6060409@samsung.com>
In-Reply-To: <5677662C.6060409@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 12/21/2015 5:38 AM, Chanwoo Choi wrote:

>>> This patch depend on GPIOLIB configuration as following:
>>> I modified it with following diff and applied it.
>>>
>>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>>> index ba4db7d..3d89e60 100644
>>> --- a/drivers/extcon/Kconfig
>>> +++ b/drivers/extcon/Kconfig
>>> @@ -54,6 +54,7 @@ config EXTCON_MAX14577
>>>
>>>    config EXTCON_MAX3355
>>>           tristate "Maxim MAX3355 USB OTG EXTCON Support"
>>> +       depends on GPIOLIB || COMPILE_TEST
>>
>>     If it won't compile w/o gpiolib, what's the use of COMIPLE_TEST?
>>     And no, it shouldn't depend on gpiolib. It has empty stubs for the case of CONFIG_GPIOLIB=n. Obviously something is wrong with the GPIO headers, I'll look into it.
>
> Yes. When GPIOLIB is disabled, the build issue don't happen.

    What? It surely does happen!

> because include/linux/gpio/consumer.h implement the dummy function
> for all gpio functions if CONFIG_GPIOLIB is disabled.

    Linus W. advised to #include this header explicitly -- I'll try and post.

> For correct operation of max3355, you should add the dependency
> to the extcon-max3355.c driver. This driver use the GPIO library
> certainly.

    I disagree. The driver will just cease to load in this case. I don't see 
why we need such dependency. Only compilation time dependencies should be
specified, I think.

> COMPILE_TEST is used for just build test. You can see the detailed data[1].
> [1] https://lkml.org/lkml/2013/5/22/155

    I know. Re-read my question please.

> Thanks,
> Chanwoo Choi

MBR, Sergei

