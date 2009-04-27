From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 27 Apr 2009 04:53:38 +0000
Subject: Re: [Proposal][PATCH] sh: clkfwk: Add resume from standby support.
Message-Id: <49F53A52.4060307@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49EC706C.4000302@st.com>
In-Reply-To: <49EC706C.4000302@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul, Magnus
Any feedback on that?
Regards
 Francesco
Francesco VIRLINZI ha scritto:
> Hi all
>
> As already done to resume from hibernation I would add a standard way to
> manage the resume from standby in the clock framework.
>
> To do that each clock has to declare to the clock framework what it 
> has to do with the clock it-self.
>
> As general rule during a standby a clock can be:
> - reduced or
> - disabled
>
> therefore in the flags field the clock has to specify what it wants.
>
> The ratio in standby is a specified with the highest 16 bits in the 
> flags fields with a rule:
>
> #define CLK_PM_EXP_SHIFT       (24)
> #define CLK_PM_RATIO_SHIFT     (16)
>
> ratio = ((clk->flags >> CLK_PM_RATIO_SHIFT) & 0xff) << ((clk->flags >> 
> CLK_PM_EXP_SHIFT) & 0xff);
>
> While to enable/disable I'm using the convention that if the
>
> (clk->flags & CLK_PM_TURNOFF) = CLK_PM_TURNOFF)
>
> than the clock has to be disabled.
>
>
> In this manned in a single place (where the clock topology is 
> designed) the developers
> can design also the configuration during the standby.
>
> What do you think?
> Regards
> Francesco

