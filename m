From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Thu, 09 Apr 2009 08:29:49 +0000
Subject: Re: [PATCH] sh7786: modify usb setup timeout judgment bug.
Message-Id: <49DDB1FD.9050100@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
References: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

morimoto.kuninori@renesas.com wrote:
> Dear Michael
>
> Thank you for advice.
>
>   
>> I think that this initialization function maybe pass to the platform 
>> data of the
>> usb driver. Give a change to go ahead and deferrable the inizialization 
>> of the system.
>>     
>
> Hmm. I can agree with you.
>
> This usb setup register have not been mapped as USB module.
> And, (I think) "current" usb driver (sh_ohci/r8a66597)
> can not call peculiar init function.
>
> I think following step is best.
>
> 1) Change usb driver to be able to call peculiar init function.
> 2) setup-sh7786 set peculiar init funtion to usb driver.
> 3) usb driver call it when start
>
> How about this idea ?
>   
I think that is a good approch. If it is possible, before the setup, the 
best
thing is to test if the bootloader has just enable it and skip the setup 
part in that
case.
Michael
> Best regards
> --
> Kuninori Morimoto
>  
>
>   

