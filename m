From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 24 Mar 2009 07:00:20 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <49C88504.2030505@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
> Hi Magnus
> I think I understood how your system works.
>
> Tell me if I'm wrong...
>
> It seems all your instructions accepts zero of at least one argument 
> and all the ' 1: bra 1f'  are used to preload.
>
> The main issue, I see, is that there is no conditional statement 
> possible.
>
> I tryed to build something like:
>
> void while_eq(unsigned long *add, unsigned long mask, unsigned long addr)
> {
>    for (; ((*add) & mask) != value; );
> }
>
> but
>
> sh_pm_op(info, SH_PM_OP_MOV_MEM32_R0, _ADDR_);
> sh_pm_op(info, SH_PM_OP_AND_IMM_R0,  _MASK_);
> sh_pm_op(info, SH_PM_OP_CMP_R0, _VALUE));
> sh_pm_op(info, SH_PM_OP_BT, __LABEL__);
>
> On 'SH_PM_OP_CMP_R0' it isn't really a problem... It could be build 
> like the other instruction...
>
> While on 'SH_PM_OP_BT' it could be a problem because we don't know the 
> 'label' address... but I think it
> could be resolved if the sh_pm_op() instead of void returns the 
> address of just assembled operation
> therefore I should be able to build something like:
>
> addr = sh_pm_op(info, SH_PM_OP_MOV_MEM32_R0, _ADDR_);
> sh_pm_op(info, SH_PM_OP_AND_IMM_R0,  _MASK_);
> sh_pm_op(info, SH_PM_OP_CMP_R0, _VALUE));
> sh_pm_op(info, SH_PM_OP_BT, addr); /* to jump backward... */
>
> Something similar could be done to jump forward... also in this case 
> the 'jump' should
>  be marked in a first phase as incomplete...  and resolved when all 
> the code is built.
>
> At least in a first release the jump forward could be not supported.
I was thinking that the jump forward could be closed with a function:

void sh_pm_set_data(unsigned long *addr, unsigned long data); /* to set 
the data field in the instruction*/

In this manner
a jump forward could be done with:

jump_addr = sh_pm_op(info, SH_PM_OP_BT, 0); /* to jump forward... zero 
doesn't matter*/
...
...
jump_target = sh_pm_op(info, ....);
sh_pm_set_data(jump_addr, jump_target); /* to set the right data value 
in the previous jump */

In this manner both the jumps are supported.
And with an ADD or a SUB instruction also some delay can be built on top 
of these instructions.
Let me know.
Regards
 Francesco
