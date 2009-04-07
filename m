From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 07 Apr 2009 20:27:58 +0000
Subject: Re: [PATCH] sh: clkfwk: Changed the init function
Message-Id: <20090407202758.GE31923@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1505.7000500@st.com>
In-Reply-To: <49BA1505.7000500@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09:24 Thu 19 Mar     , Francesco VIRLINZI wrote:
> Hi Paul
>> The clock framework itself also specifies that no assumptions can be made
>> about the state of the clock, so you must call clk_enable() to enable the
>> clock after bumping the refcount with clk_get(), and then and only then
>> can you determine if there is a problem with the clock settings.
> I understand you point of view... and also my example was not so good!
> Let me try again ;-)
>
> Now in the clock fmwk we have also clk_set_parent/clk_get_parent this means
> we can change the topology on the fly (we have this behavior with video  
> clocks).
>

IIRC the clock B can be but not the A so on the ST40 will have programmable
clock and static clock

so we must not allow people so change them

> From my point of view the .init function should also initialize the  
> clk->parent field based
> on the loaded hw setting... (I assume we can not hard-code something  
> like clk_x->parent = &clk_y;
> just because something like that it's strictly based on hardware value  
> on power-up).
why?
on some arm we hardcode because it's hardcode in the soc
>
> Therefore I can trust the clk->parent value only after a call to the  
> .init function.
after the register for non programmable clock
>
> But with the current clfwk is mandatory that a topology change can be  
> done _only_ after the clock
> is enabled while in my point of view I should be able to change the  
> topology without this constraint.
but when changing is parent we could have to disable the child before doing
it in somecase

Best Regards,
J.
