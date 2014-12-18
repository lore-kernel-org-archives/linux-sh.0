From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Dec 2014 09:48:48 +0000
Subject: Re: [PATCH v2 00/05] ARM: shmobile: sh73a0 and kzm9g Multiplatform revisit
Message-Id: <CAMuHMdU4NXy2-UmVhBxUGz-h3qvLhMViWCCusjJkQs1326rDLA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094204.7039.45337.sendpatchset@w520>
In-Reply-To: <20141217094204.7039.45337.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Dec 18, 2014 at 10:09 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> EXCEPT for "[PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load
>> address", which I'd like to NAK because it drops 25% of RAM.
>
> Ok, but the patch isn't dropping 25% of the RAM, the memory node is
> the same as before. It is just the ARM memory handling implementation
> that skips over that memory for some reason. =)
>
> So how do you think we should fix it?

Historically, Linux didn't support memory with a physical address that's
below the physical address where the kernel lives. That's a relic from PCs,
where memory starts at address zero (and is contiguous). So you best load
the kernel at the lowest possible address, else you loose all memory below it.
Only when SMP NUMA arrived, support for memory below the kernel was
added. To use it, you have to enable CONFIG_SPARSEMEM, IIRC.

IMHO the simplest solution is to reclaim the first 16 MiB, which was reserved
for the SH core.
Is anyone using the SH core? Perhaps it can use the last 16 MiB of RAM
instead?

(Sidenote: On m68k, where you typically have many discontiguous memory
 chunks, and the kernel is not always running in the chunk with the lowest
 physical address, we used to have a special trick. We used the MMU to
 map all memory chunks in the order we wanted to form one big virtual
 memory block. So instead of having one big physical block starting at
 address zero like on PC, we had one big virtual block starting at some
 specific virtual address. However, this code had to be dropped when the
 mm subsystem was changed.
 So now we make sure we order the chunks are ordered by physical address,
 and that the kernel is loaded in the first chunk. This is suboptimal, as the
 first memory chunk is not necessarily the fastest one, but so far no one has
 stepped up to write the code to use SPARSEMEM on m68k.)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
