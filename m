From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Tue, 31 Mar 2009 09:08:25 +0000
Subject: Re: gdbserver on sh4
Message-Id: <49D1DD89.1050006@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
References: <49D1D2F6.1000206@gandalf.sssup.it>
In-Reply-To: <49D1D2F6.1000206@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Paul Mundt wrote:
> On Tue, Mar 31, 2009 at 11:02:38AM +0200, Michael Trimarchi wrote:
>   
>> Paul Mundt wrote:
>>     
>>> On Tue, Mar 31, 2009 at 10:23:18AM +0200, Michael Trimarchi wrote:
>>>       
>>>> The problem is kernel side and not gdb side. I send a patch to the
>>>> linux-sh mailing list. They save the dsp register on the stack before
>>>> the processor cpu register but the offset of the struct is wrong
>>>> calculated and if the linux kernel is compiled with the dsp option
>>>> the PEEKUSR return the wrong register value.
>>>>    
>>>>         
>>> The sanest thing really is just to throw the DSP state in to the thread
>>> struct as we do with the FPU, and kill off all of the special DSP state
>>> handling we have today. It costs us a thread flag to do lazy context
>>>  
>>>       
>> I just send a patch that put the dsp state in the thread struct
>>     
>
> You sent a patch that cached the enable/disable state in the thread
> struct, not the register state. ;-) 
>
>   
>>> switching, but it's worth it to get that crap out of the regular register
>>> save/restore paths, which is just way too fragile, and has not seen any
>>> real maintenance since SH3-DSP.
>>>  
>>>       
>> So move the save/restore part of the dsp in private data of task and do like
>> mips?
>>     
>
> Yes.
>   
Ok, I will try to provide a new patch to move out the dsp save/restore 
part from the
stack and move all on the thread privata data.

Michael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

