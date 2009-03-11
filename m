From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 11 Mar 2009 14:31:38 +0000
Subject: Re: [Proposal][PATCH] sh: Suspend in Ram on sh4
Message-Id: <49B7CB4A.7060907@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B66A0E.1020400@st.com>
In-Reply-To: <49B66A0E.1020400@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi again Magnus
> ...
> Just curious, how many different SoCs do you support with suspend?
Currently seven... ~11-12 for the end of the year...
> ...
>
>
> The only code that needs special care is the self refresh code and
> whatever runs when the system ram is put in self refresh. What happens
> before and after can be written in C or assembly as usual.
Agreed!
>> The assembly code preloads (with a jump sequence) in cache (both I$ and D$)
>> the 'instruction-table'
>> and after that it executes the instruction-table.
>
> I tried to figure out how this cache population is working, but i
> still don't understand. =) Something is magical with your JUMPER().
> And you need both populate both instruction and data cache, right?
Yes you are right!
As I said in the ST40 we removed the ipref instruction and we removed also
 the cache memory mapped therefore the only way to preload the code  in 
the ICache is executing it..

When the linux calls the 'sh4_suspend' the CPU begins a sequence of 
jumps "to ping" all the Icache line (but
 I'm not really executing code... I'm only jumping from a label to the 
next label...) until the
 end of the code where it jumps on 'sh4_really_suspend' where the CPU 
really executes the code (now in Icache).
>
> How do you save data without writing to the self-refreshing ram?
Both the 'instruction table' and the 'writable-table' are preloaded in 
Dcache.
> Copy-back configuration with guaranteed space?
>
> I like the idea with an interpreter. But I get the feeling that you're
> using the interpreter to set all sorts of register configurations -
> not only the ones that setup/restore self-refresh and sleep. Am I
> wrong?
No you aren't.
You are  right, I sets also some clocks but using the interpreter 
basically you can do what you want for example
 in a SOC the last thing I do to enter in standby isn't a sleep... it's 
a write in the ClockIP to turn-off the sh4_clk...
 the wakeup event routed to the ClockIP will ("automatically") turn-on 
again the sh4_clk.... therefore it's a kind
 of 'hard' sleep instruction.... (without sleep instruction)

Also in this case the code to manage the clock has to be in icache.
>
> I'm not sure what the best way forward is. Are you planning on
> submitting upstream support for some SoC?
Not so easy submit the per SOC code also because we use an older kernel 
than the original kernel.org (I'm on 2.6.23).
>  That would be nice so we
> could share the same power management code.
I'm already sharing this code for that reason.
Ciao
  Francesco

