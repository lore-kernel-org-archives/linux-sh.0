From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 18 Mar 2009 14:17:14 +0000
Subject: Re: On "sh: Consolidate SH-Mobile CPU code in arch/sh/kernel/cpu/shmobile/."
Message-Id: <49C1026A.3040308@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF4B7C.2090607@st.com>
In-Reply-To: <49BF4B7C.2090607@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
>> For this reason in the interpreter there is no real instruction 'data'
>> oriented...
>> Each interpreter instruction works with the i-th element of an k-th
>> ioresources.
>>     
>
> So you may pass the base address of some hardware block as a resource,
> and then use offset from the base address to get to registers inside
> the hardware block. Or did I misunderstand?
>   
No you didn't. You are right the interpreter can manage registers inside 
the hardware block.
> I'd go with fixed sized operations where one operation is maximum one
> cache line. And the first part of each operation has an instruction
> that just does a jump to the beginning of the next operation (next or
> same cache line). This jumping will go on until a magic end operation
> is reached. That's how I would preload the operations.
>   
Ok.
> Each operation has two entry points, one for preloading and another
> one for running the actual code.
>
> Together with this we need code that generates the operations for us.
> A bit like a relocator or linker. I imagine that each operation is
> implemented in assembly, and data needed by the operation is located
> in the end at a fixed offset from the beginning of the operation. Then
> we have C functions that just copies the code into a destination
> address and fills in the data with whatever needed.
>
> And for each processor or board we have some code that calls the C
> functions that generates the operations for us. The argument to these
> functions can be anything.
>
> A bit like QEMU. =)
>
>
> Wouldn't a 32-bit pointer work well for you?
>   
Yes
> So basically I'd like to get rid of the your resource + offset
> abstraction and go with regular addresses. What do you think?
>   
The main reason of 'resource + offset' was due on a different PMB usage 
model in our kernel.
But more probably with your "relocator - linker" at runtime I should be 
able to close every issue.


Do you have already some stuff/prototype?
Regards
 Framcescp
