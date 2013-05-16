From: Rob Herring <robherring2@gmail.com>
Date: Thu, 16 May 2013 22:44:15 +0000
Subject: Re: [PATCH] <linux/of_platform.h>: fix compilation warnings with DT disabled
Message-Id: <CAL_JsqLkshrBDDKtdf+KYufg=83Yn7zAFmHKUpoA848JzbQKmw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201302190258.25726.sergei.shtylyov@cogentembedded.com>
	<20130301070925.GA24369@verge.net.au>
	<5130B12F.20409@gmail.com>
	<5130B1A7.9060001@gmail.com>
	<5130B34F.2090700@cogentembedded.com>
	<5130B506.5020908@gmail.com>
	<5195486F.1040603@cogentembedded.com>
In-Reply-To: <5195486F.1040603@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, vladimir.barinov@cogentembedded.com

On Thu, May 16, 2013 at 3:58 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 03/01/2013 05:02 PM, Rob Herring wrote:
>
>>>>>>> Fix the following compilation warnings (in Simon Horman's
>>>>>>> renesas.git repo):
>>>>>>> In file included from arch/arm/mach-shmobile/setup-r8a7779.c:24:0:
>>>>>>> include/linux/of_platform.h:107:13: warning: =91struct of_device_id=
=92
>>>>>>> declared
>>>>>>> inside parameter list [enabled by default]
>>>>>>> include/linux/of_platform.h:107:13: warning: its scope is only this
>>>>>>> definition
>>>>>>> or declaration, which is probably not what you want [enabled by
>>>>>>> default]
>>>>>>> include/linux/of_platform.h:107:13: warning: =91struct device_node=
=92
>>>>>>> declared
>>>>>>> inside parameter list [enabled by default]
>>>>>>> <linux/of_platform.h> only #include's headers with definitions of
>>>>>>> the above
>>>>>>> mentioned structures if CONFIG_OF_DEVICE=3Dy but uses them even if
>>>>>>> not. One
>>>>>>> solution is to move some #include's out of #ifdef CONFIG_OF_DEVICE
>>>>>>> and use
>>>>>>> incomplete declarations for the rest of the structures where the
>>>>>>> #ifdef move
>>>>>>> doesn't help...
>>>>>>> Reported-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>>>>
>>>>>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>>>>>> Grant, could you consider taking this patch?
>>>>>
>>>>> Yes, I can, but I don't seem to have the original patch. Can you send
>>>>> it
>>>>> again.
>>>>
>>>> Nevermind. Found it. I'll apply it.
>>>
>>>     Will you drop 'struct device_node' declaration then or should I
>>> resend? In fact, I think I should better resend it with the changelog
>>> somewhat edited.
>>
>> No, I plan to leave it as is and not rely on device.h by chance
>> declaring device_node.
>
>
>     I hoped to see this fix in 3.10-rc1. Is there any hope to see it in
> 3.10-rc's?
> The code it fixes the warnings in is already in Linus tree.

So I had this queued up, but Grant did not send DT update to Linus for
3.10. The main thing we had was the preprocessor support and that went
thru arm-soc tree. I plan to send this and other fixes to Linus for
3.10.

Rob
