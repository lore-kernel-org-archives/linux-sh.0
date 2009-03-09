From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 09 Mar 2009 09:27:03 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <49B4E0E7.6000905@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Jean-Christophe
>>>   
>>>       
>> You are right until you don't use module.
>> If you use a "mini-kernel" with several modules... when you will resume  
>> from hibernation at the begin
>> you boots again the 'mini-kernel'... after that you restore the previous 
>> image and the irq line required by
>> module more probably remains as it was (not-initialized).
>>     
> the module will have to handle this itsself
> because the kernel can not known the specicifity of each device init sequence
>   
My issue was on interrupt controller initialization.

A module loaded during runtime can do request_irq/free_irq to manage the 
irq line initialization.
I'm assuming during the suspend the module doesn't have to free the irq 
and on resume require again the same irq (just to initialize the irq 
line on the interrupt controller).

I think it's more realistic a module (the device_driver) turns-off 
its-own "irq capability" on the device (not on the interrupt 
controller), this means on resume the module (device_driver)  will 
turn-on the irq capability (again on the device)... but the irq line on 
the interrupt controller still  remain not-initialized.

I hope this clarify my view.

Regards
 Francesco

> Best Regards,
> J.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

