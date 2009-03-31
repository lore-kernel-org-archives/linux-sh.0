From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Tue, 31 Mar 2009 09:02:38 +0000
Subject: Re: gdbserver on sh4
Message-Id: <49D1DC2E.2060105@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
References: <49D1D2F6.1000206@gandalf.sssup.it>
In-Reply-To: <49D1D2F6.1000206@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Tue, Mar 31, 2009 at 10:23:18AM +0200, Michael Trimarchi wrote:
>   
>> binom wrote:
>>     
>>> Dear michael ,
>>> In your reply message it's written that "I fix this problem".
>>> Can you pl explain what was the problem and and which is the components to
>>> be updated for incorporating this fix?
>>> Below given is the details of the host side GDB and target side gdbserver.
>>> sh4-linux-gdb --version
>>> GNU gdb STMicroelectronics/Linux Base 6.5-33 [build Jul 30 2008]
>>> Copyright (C) 2006 Free Software Foundation, Inc.
>>> GDB is free software, covered by the GNU General Public License, and you 
>>> are
>>> welcome to change it and/or distribute copies of it under certain
>>> conditions.
>>> Type "show copying" to see the conditions.
>>> There is absolutely no warranty for GDB.  Type "show warranty" for details.
>>> This GDB was configured as "--host=i686-pc-linux-gnu --target=sh4-linux".
>>>  
>>>       
>> The problem is kernel git clone git://git.openmoko.org/git/kernel.git linux-2.6
>> side and not gdb side. I send a patch to the linux-sh
>> mailing list. They save the dsp register on the stack before the 
>> processor cpu register
>> but the offset of the struct is wrong calculated and if the linux kernel 
>> is compiled
>> with the dsp option the PEEKUSR return the wrong register value.
>>
>>     
> The sanest thing really is just to throw the DSP state in to the thread
> struct as we do with the FPU, and kill off all of the special DSP state
> handling we have today. It costs us a thread flag to do lazy context
>   
I just send a patch that put the dsp state in the thread struct
> switching, but it's worth it to get that crap out of the regular register
> save/restore paths, which is just way too fragile, and has not seen any
> real maintenance since SH3-DSP.
>   
So move the save/restore part of the dsp in private data of task and do like
mips?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
Michael
