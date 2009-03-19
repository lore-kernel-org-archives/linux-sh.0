From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Mar 2009 05:39:16 +0000
Subject: Re: On "sh: Consolidate SH-Mobile CPU code in arch/sh/kernel/cpu/shmobile/."
Message-Id: <aec7e5c30903182239t63db89c2k15786bc83e4dfca@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF4B7C.2090607@st.com>
In-Reply-To: <49BF4B7C.2090607@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Francesco!

On Wed, Mar 18, 2009 at 11:17 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> Hi Magnus
>>>
>>> For this reason in the interpreter there is no real instruction 'data'
>>> oriented...
>>> Each interpreter instruction works with the i-th element of an k-th
>>> ioresources.
>>>
>>
>> So you may pass the base address of some hardware block as a resource,
>> and then use offset from the base address to get to registers inside
>> the hardware block. Or did I misunderstand?
>>
>
> No you didn't. You are right the interpreter can manage registers inside the
> hardware block.

Good. Then we're on the same page!

>> I'd go with fixed sized operations where one operation is maximum one
>> cache line. And the first part of each operation has an instruction
>> that just does a jump to the beginning of the next operation (next or
>> same cache line). This jumping will go on until a magic end operation
>> is reached. That's how I would preload the operations.
>>
> Ok.

Do you think the above would work in your case?

>> So basically I'd like to get rid of the your resource + offset
>> abstraction and go with regular addresses. What do you think?
>>
>
> The main reason of 'resource + offset' was due on a different PMB usage
> model in our kernel.
> But more probably with your "relocator - linker" at runtime I should be able
> to close every issue.
>
>
> Do you have already some stuff/prototype?

No, no code exists at this point. I hope to find some time to hack up
a prototype next week. We probably need a couple of iterations before
we both are happy so I suspect the interpreter stuff would be 2.6.31
material. Is that ok, or do you have any special requirements from
your side?

I also need to focus on fixing up the clock framework and cpuidle. And
cpufreq of course. Many things. =)

Cheers,

/ magnus
