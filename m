From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Apr 2016 20:10:40 +0000
Subject: Re: [PATCH 7/7] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <CAMuHMdWC+ih5S4U_sLjfgGtLdOEjV9Z2PJ1bM9s2XP5NViaifA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
In-Reply-To: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich,

On Fri, Apr 29, 2016 at 6:06 PM, Rich Felker <dalias@libc.org> wrote:
> On Fri, Apr 29, 2016 at 08:58:44AM +0200, Geert Uytterhoeven wrote:
>> On Thu, Apr 7, 2016 at 5:01 PM, Rich Felker <dalias@libc.org> wrote:
>> > +               cpu@0 {
>> > +                       device_type = "cpu";
>> > +                       compatible = "jcore,j2";
>>
>> This brings an interesting question: how do you plan to do IP core versioning?
>> I.e. which version of the HDL code does "jcore,j2" correspond to?
>
> It's a question I'd like input on, because both the kernel driver
> architecture and DT seem to have been designed with fixed hardware
> devices in mind, not soft cores and updatable hardware.

The issue is not limited to softcores and updatablt hardware. Even for
normal SoCs of the same family, it's not guaranteed that two on-SoC
device with the same name and same documentation are identical revisions
of that device.

Of course you can fix hardware bugs and add hardware features on the
fly ;-)

> For cpu nodes, I take the compatible tag mostly as just reflective of
> the ISA and other broad cpu architecture characteristics. My intent in
> the DT representation has been to factor out everything else, even
> "L1" cache, as a separate device that can be represented on its own.
> For example if you remove the cache node from the DT, the system will
> boot with icache and dcache disabled (and will run really slow).

OK.

> The main places it might be nice to know about specific cpu versions
> are when new instructions are added, and when there are significances
> in instruction timings that might matter to performance. But both of
> these are cases where we'd probably want a public-facing name of some
> sort (e.g. something like j2-rev2, j2+, ...) and the DT compatible tag
> caan just be aligned with it.
>
> For devices which have different generations with different
> programming interfaces or capabilities the driver needs to know about,
> I've done things like "aic1" vs "aic2", etc. Soon there will be "spi3"
> for the (wip) spi master with a DMA-based interface.

OK.

> Other than that, what to do about version details for the sake of
> working around small bugs? It's complicated by the possibility that a
> bug might even be caused by the bitstream generation for a particular
> FPGA/board, not the source, so a source version might not even
> suffice. My leaning for FPGA builds is just to put detailed soc-wide
> board-target and version information in the top-level DT node (note:
> once the DT bindings are official, DTB will be included in the boot
> rom in the FPGA bitream) with the expectation that it's unlikely to be
> used, but useful to have for bug reporting, etc., and that if you have
> a buggy build, you should just fix/upgrade it rather than trying to
> work around it on the kernel side. For future ASICs, OTOH, we should
> probably coordinate having production-run-specific information in the
> DT bindings in case there are bugs to be worked around.

Hmm, I never considered the bitstream generation making a difference,
so e.g. having the git SHA1 ID for a component in a read-only hardware
registers is no longer sufficient to uniquely identify it.

> Does this approach make sense? If so, it might make sense to write up
> the ideas/rational as a proposal for inclusion in the DT docs, for
> future soft-core projects to use as guidelines.

Yes it does.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
