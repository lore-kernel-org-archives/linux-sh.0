From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 23 Mar 2009 10:29:54 +0000
Subject: Re: On "sh: Consolidate SH-Mobile CPU code in arch/sh/kernel/cpu/shmobile/."
Message-Id: <aec7e5c30903230329mc9a3fceya54b27dc68cd6528@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF4B7C.2090607@st.com>
In-Reply-To: <49BF4B7C.2090607@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Mar 19, 2009 at 4:17 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> What do you mean with 'page'? I don't see 'page' issue until we don't use
> the TLB

Hehe, sorry for my unclear language. I didn't mean page as memory
management unit. =3D)

>> No, no code exists at this point. I hope to find some time to hack up
>> a prototype next week. We probably need a couple of iterations before
>> we both are happy so I suspect the interpreter stuff would be 2.6.31
>> material. Is that ok, or do you have any special requirements from
>> your side?
>>
>
> It isn't a real problem for me.
> In February we did our first kernel release with =A0pm support and I can
> maintain this
> code until the official pm support will be integrated in the kernel after
> that I will (slowly..)
> move our SOCs in the new pm infrastructure.
> Let me say I have my 'recovery' solution therefore the time required
> for investigation/design/prototype isn't a problem.

Good. Sounds like you will be able to spend some time in the future.

>> I also need to focus on fixing up the clock framework
>
> What about clock framework?
> I'd like an integrated support for standby (as I did for hibernation... a=
lso
> if I know the standby is more difficult
> than hibernation).

I agree. What more is needed for standby in your opinion?

Cheers,

/ magnus

PS. If you have time, please fix clock framework warning in sh-2.6
introduced by suspend code (i think).
