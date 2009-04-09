From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Thu, 09 Apr 2009 10:04:21 +0000
Subject: Re: [PATCH] sh7786: modify usb setup timeout judgment bug.
Message-Id: <49DDC825.4080101@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
References: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Yoshihiro Shimoda wrote:
> Hi Morimoto-san,
>
> morimoto.kuninori@renesas.com wrote:
>> Dear Michael
>>
>>>>> shimoda san
>>>> Can you change use driver to be able to call peculiar init function ?
>>>> Or Can I do that ?
>>>>   
>>> I will try to provide a patch if you want on 14 of April, or if you 
>>> prefer just start and
>>> send a patch to the reviewer :)
>> Ooops. sorry.
>> My request is to "shimoda san" who created usb driver for SH :)
>>
>
> I think that it is after next month if I try it.
> Because linux-2.6.30 merge window was just closed recently :)
>
I don't have all the data. Look at the code there only the init function 
to be
deferrable. Introduce a platform data it can be usefull but I would like to
know if there are other info that can be passed with the platform data.
Is that the only cpu that needs a specific initialization? Before a patch
maybe we can ask how can we use it?
Just to know:
what is this function sh7786_usb_use_exclock?

for example the s3c2410 define and use a platform data, for port flags or
power control or overun current situation. What can we put in a platform 
data?

Michael



-
> Thanks,
> Yoshihiro Shimoda
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

