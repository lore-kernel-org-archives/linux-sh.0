From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Fri, 10 Apr 2009 01:24:32 +0000
Subject: Re: [PATCH] sh7786: modify usb setup timeout judgment bug.
Message-Id: <49DE9FD0.8080208@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

Paul Mundt wrote:
> On Thu, Apr 09, 2009 at 08:08:21PM +0900, Yoshihiro Shimoda wrote:
>> Michael Trimarchi wrote:
>>> Is that the only cpu that needs a specific initialization? Before a patch
>>> maybe we can ask how can we use it?
>>> Just to know:
>>> what is this function sh7786_usb_use_exclock?
>> SH7763's OHCI need initialization too
>> (but differ proccess: arch/sh/board/mach-sh7763rdp/setup.c: line 172).
>>
>> I'm sorry, I don't know detail of this function.
>> Morimoto-san, please tell me this information?
>>
>>> for example the s3c2410 define and use a platform data, for port flags or
>>> power control or overun current situation. What can we put in a platform 
>>> data?
>> The Renesas usb host controllers are:
>>  - OHCI (drivers/usb/host/ohci-sh.c)
>>  - r8a66597 (drivers/usb/host/r8a66597-hcd.c)
>>
>> In OHCI, we can put extend initialize function in a platform data only at the moment.
>> However, in r8a66597, we can put all module_param data.
>>
> I don't see any reason why we can't accomodate the r7a66597 platform data
> change within -rc2, so if that is the way you want to fix this, then that
> should be fine. Of course if it is too invasive, we will just use the
> original fix in the board, but there is not much point in doing a
> stop-gap fix if we already have some plan on how to fix it properly.

Thank you for your comment!
I will try this changing properly. But I may need much time.

Thanks,
Yoshihiro Shimoda

