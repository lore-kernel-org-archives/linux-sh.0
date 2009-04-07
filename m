From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 07 Apr 2009 08:25:00 +0000
Subject: Re: [PATCH] sh: clkfwk: Changed the init function
Message-Id: <49DB0DDC.2050800@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1505.7000500@st.com>
In-Reply-To: <49BA1505.7000500@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul
I'm sorry if I'm boring you.
Any replay on the below issue?
Regards
 Francesco
Francesco VIRLINZI ha scritto:
> Hi Paul
>> The clock framework itself also specifies that no assumptions can be 
>> made
>> about the state of the clock, so you must call clk_enable() to enable 
>> the
>> clock after bumping the refcount with clk_get(), and then and only then
>> can you determine if there is a problem with the clock settings.
> I understand you point of view... and also my example was not so good!
> Let me try again ;-)
>
> Now in the clock fmwk we have also clk_set_parent/clk_get_parent this 
> means
> we can change the topology on the fly (we have this behavior with 
> video clocks).
>
> From my point of view the .init function should also initialize the 
> clk->parent field based
> on the loaded hw setting... (I assume we can not hard-code something 
> like clk_x->parent = &clk_y;
> just because something like that it's strictly based on hardware value 
> on power-up).
>
> Therefore I can trust the clk->parent value only after a call to the 
> .init function.
>
> But with the current clfwk is mandatory that a topology change can be 
> done _only_ after the clock
> is enabled while in my point of view I should be able to change the 
> topology without this constraint.
>
> Once a clock is registered I should be able to call clk_set_parent 
> without being forced to enable it.
>
> Moreover it could be dangerous for the devices that are using the 
> clock because first of all I have to
> enable the clock.. and only after that I can change (if required) the 
> clk->parent (while the clock is running).
>
> Regards
> Francesco
