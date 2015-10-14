From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Oct 2015 07:04:43 +0000
Subject: Re: renesas-drivers-2015-10-13-v4.3-rc5
Message-Id: <CAMuHMdWquZK_OZbqGCgqj5f=wnCsEzMUhCXVjV8_jN6-7OSqBA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444732125-12741-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444732125-12741-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Oct 14, 2015 at 2:39 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Oct 13, 2015 at 12:28:45PM +0200, Geert Uytterhoeven wrote:
>> I've pushed renesas-drivers-2015-10-13-v4.3-rc5 to
>> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
>> This tree is meant to ease development of platform support and drivers for
>> Renesas ARM ("shmobile") SoCs. It's created by merging (a) the for-next
>> branches of various subsystem trees and (b) branches with driver code
>> submitted or planned for submission to maintainers into the development
>> branch of Simon Horman's renesas.git tree.
>>
>> Today's version is based on renesas-devel-20151013v2-v4.3-rc5.
>>
>> Notes:
>>   - As topic/gen3-cpg-v8+fix and topic/arm64-rcar-gen3-v10.1 started
>>     using the cpg-mssr driver instead of the cpg-mstp driver, while
>>     later integration topic branches still used cpg-mstp bindings,
>>     several drivers (e.g. gpio, but that should affect wake-up-by-gpio
>>     only) cannot get their module clocks, or their module clocks are not
>>     managed correctly (e.g. ravb, which still works despite this).
>>     There are 3 ways to fix this:
>>       - Convert your dtsi blocks to the cpg-mssr bindings (best),
>>       - Re-add clk-mstp.o for CONFIG_ARCH_R8A7795 in
>>       drivers/clk/shmobile/Makefile, and make sure CONFIG_PM=n
>>       (untested),
>>       - Use renesas-drivers-2015-09-29-v4.3-rc3 (for the lazy consumer).
>>     However, in the light of "[PATCH/RFC v3 0/3] clk: shmobile: Add new
>>     Renesas CPG/MSSR DT bindings"
>>     (http://www.spinics.net/lists/devicetree/msg97237.html), all of the
>>     above are temporary solutions.
>
> I would like to update topic/arm64-rcar-gen3-v10.1 and post
> as v11 for further review both here and in the broader Linux ARM community
> at linux-arm-kernel@lists.infradead.org.
>
> Do you recommend updating that patchset for the above? If so in
> which way do you recommend updating it?

I'm afraid there's not much you can do before I have a new CPG/MSSR
driver that works.

You can start updating the dtsi, but you can't test it, and I had to do the same
updates to test my driver anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
