From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 30 Mar 2009 02:45:11 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <aec7e5c30903291945o2e76217bof48b509abb86015c@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Mar 25, 2009 at 11:46 PM,  <takasi-y@ops.dti.ne.jp> wrote:
>> Yoshii-san, any comments?
> I still prefer to write them in _real_ assember (without having any good =
idea), though.

I think Francesco has more complex needs. Since his processor lacks
instruction cache prefetching opcodes, he is forced to populate the
instruction cache "by hand" with jump instructions. That will of
course be "_real_" assembly, but with magic jump instructions added in
the middle to support instruction cache preload. I prefer to build-in
the cache population into the interpreter/JIT code instead. That way
we can have the same interpreter regardless if we chose to preload in
cache or execute from onchip ram.

I think Yoshii-san is proposing breaking up code into board-specific
and cpu-specific assembly code, which gets copied and run.

Francesco, can you convince yoshii-san why we should add support for
an interpreter? =3D)

>> > > But do we (you!) really need to jump forward?
>> > =A0Not really but I'd like to have no constraint if possible
>> Then I vote for adding it later when there is a direct need. You can
>> implement delay using backward jump only, right?
>
> Because this is a kind of assembler, we can use its technique, like
> making pointer link of undefined labels on its reference,
> =A0and resolve them following the link when the label is defined.
> Then the code will be
>
> =A0/* forward ref. This make link because label is not resolved */
> =A0sh_pm_op(info, SH_PM_OP_BT, sh_pm_ref(info, &label));
> =A0/* define label, and resolve above using linked list */
> =A0sh_pm_label(info, &label); /* define label, and resolve above */
> =A0/* backward ref. This simply use label value */
> =A0sh_pm_op(info, SH_PM_OP_BT, sh_pm_ref(info, &label));

Sounds pretty clean. I guess it will become a bit more complex since
multiple opcomes may jump to the same label. So we may need to do a
linked list with per-opcode allocation. Unless we misuse the IMM field
in the opcode for a single linked list somehow. =3D)

> But, I don't think we need even backward jump.
> What we want is conditional wait and delay, isn't it?
>
> SH_PM_OP_WAIT_UNTIL_EQ(addr, value) while(read(addr)!=3Dvalue)/*wait*/;
> SH_PM_OP_WAIT_UNTIL_SET(addr, mask) while(!(read(addr)&mask))/*wait*/;
> SH_PM_OP_WAIT_UNTIL_CLR(addr, mask) while(read(addr)&mask)/*wait*/;
> SH_PM_OP_DELAY_LOOP(count) while(count--)/*wait*/;

I wonder if we can make those opcodes fit with the current format?
Maybe no. They look fine with me though, but I'm not sure about
Francescos use case.

I'll try to find time to post V2 this or next week.

Cheers,

/ magnus
