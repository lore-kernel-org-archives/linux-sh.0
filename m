From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Mar 2009 09:53:30 +0000
Subject: Re: On "sh: Consolidate SH-Mobile CPU code in arch/sh/kernel/cpu/shmobile/."
Message-Id: <aec7e5c30903180253h4b0bfd44t5627d1c793aa9d09@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF4B7C.2090607@st.com>
In-Reply-To: <49BF4B7C.2090607@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Francesco,

Thanks for your email and all your patches. Sorry for slow response.

On Tue, Mar 17, 2009 at 11:43 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
>> My main question is: Do you really need to be able to load and save
>> data from the interpreter?
>
> This isn't really a problem or an issue.

From a functional point of view I'm sure your interpreter is just
fine. We just need to discuss how to do it in a simple and powerful
way. Maybe your patch is all that already, but if so I need time to
understand it.

Things like this takes time. I must have made at least 5 different
intc prototypes before i got something that was simple and still
powerful enough. I hope we can come up with something a bit quicker
this time though. =3D)

> The current code work mainly with only 2 tables:
> - an instruction table
> - a resource table
>
> The resource table is an array of base address of usable resource, it
> doesn't matter what the resource is... each
> resource can be hw or memory... the writable table (in my convention) is
> only the first element of
> ioresource table.
>
> For this reason in the interpreter there is no real instruction 'data'
> oriented...
> Each interpreter instruction works with the i-th element of an k-th
> ioresources.

So you may pass the base address of some hardware block as a resource,
and then use offset from the base address to get to registers inside
the hardware block. Or did I misunderstand?

>> =A0I'd prefer to just
>> generate a bunch of inline operations that we either load into the
>> cache or put in on-chip ram depending on processor type. Each
>> operation would be self-contained.
>
> I agree and for this reason I wrote several macros on top of instructions=
 to
> simplify the
> table creation, but I'd like maintain the current granularity because
> 'ad-hoc' instruction
> could be too much hw dependent and we could need to add other asm code to
> support
> any new hw... While with this instruction granularity a new hw means at
> least
> some other macro to build the right instruction the new hw needs.

I feel these multiple levels of macros and tables are a bit confusing.
Can't we just create a set of operations where each operation is fixed
size? No tables needed, everything is just put in instruction cache.

If it were up to me, then I'd go with a set of simple operations that
read and write data in memory at some address. The address should be
immediate for the operation. Those operations can point to either a
hardware register or some memory.
Maybe loading immediate and some bit manipulation operations would be
good to have as well. And you had some wait operation as well.

>> What are your requirements?
>
> In the ST40 we have no ipref instruction and in the latest version it was
> removed the
> RAM mode cache support.
> Therefore the code has to be preloaded in Icache with the jumper mechanis=
m I
> did (other suggestion?)

I'd go with fixed sized operations where one operation is maximum one
cache line. And the first part of each operation has an instruction
that just does a jump to the beginning of the next operation (next or
same cache line). This jumping will go on until a magic end operation
is reached. That's how I would preload the operations.

Each operation has two entry points, one for preloading and another
one for running the actual code.

Together with this we need code that generates the operations for us.
A bit like a relocator or linker. I imagine that each operation is
implemented in assembly, and data needed by the operation is located
in the end at a fixed offset from the beginning of the operation. Then
we have C functions that just copies the code into a destination
address and fills in the data with whatever needed.

And for each processor or board we have some code that calls the C
functions that generates the operations for us. The argument to these
functions can be anything.

A bit like QEMU. =3D)

> Moreover I don't want set constraint on how many resource the interpreter
> can use.
> This means that the interpreter should be able to manage (teorically) any=
 hw
> resource not only the dram,
> for example I strongly need access the Clocks-IP.

I agree it's best not to limit. But I think regular compiled C will
always be more efficient than interpreting, so I would go with as few
operations as possible.

Wouldn't a 32-bit pointer work well for you?

So basically I'd like to get rid of the your resource + offset
abstraction and go with regular addresses. What do you think?

Cheers,

/ magnus
