From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Thu, 19 Mar 2009 07:17:53 +0000
Subject: Re: On "sh: Consolidate SH-Mobile CPU code in arch/sh/kernel/cpu/shmobile/."
Message-Id: <49C1F1A1.6030600@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF4B7C.2090607@st.com>
In-Reply-To: <49BF4B7C.2090607@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
>> No you didn't. You are right the interpreter can manage registers inside the
>> hardware block.
>>     
>
> Good. Then we're on the same page!
>   
What do you mean with 'page'? I don't see 'page' issue until we don't 
use the TLB

>   
>>> I'd go with fixed sized operations where one operation is maximum one
>>> cache line. And the first part of each operation has an instruction
>>> that just does a jump to the beginning of the next operation (next or
>>> same cache line). This jumping will go on until a magic end operation
>>> is reached. That's how I would preload the operations.
>>>       
> Do you think the above would work in your case?
>   
Yes, I think so.
> No, no code exists at this point. I hope to find some time to hack up
> a prototype next week. We probably need a couple of iterations before
> we both are happy so I suspect the interpreter stuff would be 2.6.31
> material. Is that ok, or do you have any special requirements from
> your side?
>   
It isn't a real problem for me.
In February we did our first kernel release with  pm support and I can 
maintain this
 code until the official pm support will be integrated in the kernel 
after that I will (slowly..)
 move our SOCs in the new pm infrastructure.
Let me say I have my 'recovery' solution therefore the time required
 for investigation/design/prototype isn't a problem.

> I also need to focus on fixing up the clock framework
What about clock framework?
I'd like an integrated support for standby (as I did for hibernation... 
also if I know the standby is more difficult
 than hibernation).

Regards
 Francesco
