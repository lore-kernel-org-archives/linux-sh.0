From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 11 May 2009 13:23:06 +0000
Subject: Re: [Proposal][PATCH] sh: clkfw: Moved the .init callback in the
Message-Id: <4A0826BA.7020100@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A07EAFC.2080906@st.com>
In-Reply-To: <4A07EAFC.2080906@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
> Hi Francesco,
>
> I had a look at your patch. The idea behind the patch is fine with me
> - still untested - but I'd be happy to test the next version if you
> can improve it a bit. 
No problems I can do that... but.

Paul: I remember you had some issue on this design.

Do you agree now? Do you think the v3 is commit-able?

Let me know.

Regards
 Francesco

> Here's some feedback:
>
> Changing init() to return an int is ok with me. Not sure what Paul
> thinks about this. Anyway, to do so you need to fix your patch so all
> init() callbacks are changed. Applying this patch as-is will break
> many things.
>
> No need for the __clk_init() function any more. And please use the
> return value from the init() callback.
>
> You probably want to call init() from clk_register() after adding the
> clock to the list. Also, return the value from the init() callback, no
> need to always return -EPERM.
>
> And if possible, please send the patch inline. That makes reviewing much easier.
>
> Cheers,
>
> / magnus - waiting for a V3
>
> On Mon, May 11, 2009 at 6:26 PM, Francesco VIRLINZI
> <francesco.virlinzi@st.com> wrote:
>   
>> Sorry... THe attached was broken.
>> Here the right patch,
>> Ciao
>> Francesco
>> Francesco VIRLINZI ha scritto:
>>     
>>> Hi Magnus
>>> Here there is the patch to move the .init callback during the clock
>>> registration.
>>> Currently the __clk_init returns always zero...
>>> in the next step if the __clk_init fails the clock registration will be
>>> rejected.
>>>
>>> Let me know.
>>> Ciao
>>> Francesco
>>>       
>>     
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

