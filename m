From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 Mar 2009 11:08:26 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <aec7e5c30903240408j2997285x93bca31b821a592a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Francesco!

On Tue, Mar 24, 2009 at 4:00 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> Hi Magnus
>>
>> Hi Magnus
>> I think I understood how your system works.
>>
>> Tell me if I'm wrong...

You seem correct.

>> It seems all your instructions accepts zero of at least one argument and
>> all the ' 1: bra 1f' =A0are used to preload.
>>
>> The main issue, I see, is that there is no conditional statement possibl=
e.

Right, I thought so. Thanks for your input so far.

>> I tryed to build something like:
>>
>> void while_eq(unsigned long *add, unsigned long mask, unsigned long addr)
>> {
>> =A0 for (; ((*add) & mask) !=3D value; );
>> }
>>
>> but
>>
>> sh_pm_op(info, SH_PM_OP_MOV_MEM32_R0, _ADDR_);
>> sh_pm_op(info, SH_PM_OP_AND_IMM_R0, =A0_MASK_);
>> sh_pm_op(info, SH_PM_OP_CMP_R0, _VALUE));
>> sh_pm_op(info, SH_PM_OP_BT, __LABEL__);
>>
>> On 'SH_PM_OP_CMP_R0' it isn't really a problem... It could be build like
>> the other instruction...

Right, no problem. I guess CMP can be ADD together with AND?

>> While on 'SH_PM_OP_BT' it could be a problem because we don't know the
>> 'label' address... but I think it
>> could be resolved if the sh_pm_op() instead of void returns the address =
of
>> just assembled operation
>> therefore I should be able to build something like:
>>
>> addr =3D sh_pm_op(info, SH_PM_OP_MOV_MEM32_R0, _ADDR_);
>> sh_pm_op(info, SH_PM_OP_AND_IMM_R0, =A0_MASK_);
>> sh_pm_op(info, SH_PM_OP_CMP_R0, _VALUE));
>> sh_pm_op(info, SH_PM_OP_BT, addr); /* to jump backward... */

Looking good! Simple and efficient!

>> Something similar could be done to jump forward... also in this case the
>> 'jump' should
>> =A0be marked in a first phase as incomplete... =A0and resolved when all =
the
>> code is built.
>>
>> At least in a first release the jump forward could be not supported.
>
> I was thinking that the jump forward could be closed with a function:
>
> void sh_pm_set_data(unsigned long *addr, unsigned long data); /* to set t=
he
> data field in the instruction*/
>
> In this manner
> a jump forward could be done with:
>
> jump_addr =3D sh_pm_op(info, SH_PM_OP_BT, 0); /* to jump forward... zero
> doesn't matter*/
> ...
> ...
> jump_target =3D sh_pm_op(info, ....);
> sh_pm_set_data(jump_addr, jump_target); /* to set the right data value in
> the previous jump */
>
> In this manner both the jumps are supported.

Right, I understand. This becomes a bit more complicated but it's not
so strange. As long as the two pass setup() is ok (first pass without
buffer) then I'm ok.

But do we (you!) really need to jump forward?

> And with an ADD or a SUB instruction also some delay can be built on top =
of
> these instructions.

The opcode SH_PM_OP_ADD_IMM_R0 isn't enough?

Which other opcodes do you need?

Cheers,

/ magnus
