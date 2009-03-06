From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 06 Mar 2009 10:05:35 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <49B0F56F.2090806@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
>
> Great! You should try in on some ST hardware as well. =)
>   
Yes I could try if it works also if we already had the hibernation on 
memory on sh4.
>   
>> Is it also for sh4 with PMB? If so how are you managing the PMB?
>> Moreover what about interrupt controller? This means after a resume from
>> hibernation
>> you could have a resumed device (and driver) but the interrupt controller
>> has the right irq-line not initialized.
>>     
>
> I have not tested with PMB.
On PMB: some entries may be is already OK (the entries the bootloader 
prepared fot linux)
 but Linux has to force an hw-initialization of the other entries
>  You are right about the interrupt
> controller, but it works because swsusp resume boots up the system as
> usual with an identical kernel. Look at the attached file for the
> swsusp code flow...
>   
You are right until you don't use module.
If you use a "mini-kernel" with several modules... when you will resume 
from hibernation at the begin
 you boots again the 'mini-kernel'... after that you restore the 
previous image and the irq line required by
 module more probably remains as it was (not-initialized).

Regards
 Francesco
> Cheers,
>
> / magnus
>   

