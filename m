From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 11 Mar 2009 13:36:34 +0000
Subject: Re: [Proposal][PATCH] sh: Suspend in Ram on sh4
Message-Id: <aec7e5c30903110636r79aaf053n2ee4fd857f9949c7@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B66A0E.1020400@st.com>
In-Reply-To: <49B66A0E.1020400@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Francesco!

On Tue, Mar 10, 2009 at 10:24 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> Hi all
> I would propose an other version of suspend in ram.
>
> In ST we have several constraints:
> - Several SOCs with different Clock IPs
> - No cache memory mapped (it was removed in recently version of ST40)
> - No IPREF instruction..
> - 29/32 bits supports (where in 32 bits we are managing the PMB in a
> different manner respect the original kernel.org code).

Just curious, how many different SoCs do you support with suspend?

> For these reason an hard-coded suspend assembly code isn't easy to use for
> us.
>
> To address the issue we are using a mini interpreter able to execute macro
> instructions SOC based.

Some week ago I was considering doing something similar, but then I
decided not to. The reason for this was simplicity. My suspend patch
only supports a few processors, so it's probably not fair to compare
it with your case. So please take this with a pinch of salt. And
correct me when I'm wrong.

The only code that needs special care is the self refresh code and
whatever runs when the system ram is put in self refresh. What happens
before and after can be written in C or assembly as usual. Having some
assembly code snippet that does this is very simple. The code for
suspend that I posted recently is relocatable and does exactly this.
It should be possible to load that into the instruction cache too
unless I'm mistaken.

I realize that the self-refresh mode switching code may vary with
processor type and maybe board type as well. And having special case
handling by ifdefs in the assembly snippet is not exacly clean.

> The assembly code preloads (with a jump sequence) in cache (both I$ and D$)
> the 'instruction-table'
> and after that it executes the instruction-table.

I tried to figure out how this cache population is working, but i
still don't understand. =) Something is magical with your JUMPER().
And you need both populate both instruction and data cache, right?

> This solution allow me to have no assembly code SOCs specific and
> for each SOC I have only to produce the right "tables" for standby and/or
> mem-standby.

I understand. This is pretty neat.

> Moreover a 3rd table is supported to be able to produce or save data on the
> fly for the standby it-self (for example if we have different action on the
> same SOC but different Cut).

How do you save data without writing to the self-refreshing ram?
Copy-back configuration with guaranteed space?

I like the idea with an interpreter. But I get the feeling that you're
using the interpreter to set all sorts of register configurations -
not only the ones that setup/restore self-refresh and sleep. Am I
wrong?

I'm not sure what the best way forward is. Are you planning on
submitting upstream support for some SoC? That would be nice so we
could share the same power management code. If not then it's maybe
best that I just fix up and resend my suspend patch and we can tie in
some interpreter whenever it's needed.

Thanks for your help so far!

Cheers,

/ magnus
