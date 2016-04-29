From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Apr 2016 09:20:02 +0000
Subject: Re: [PATCH 7/7] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <CAMuHMdX4HaUN8wufkfCQoPGAC=b5AaNc6XjdJ5gyU6qU=4HT=w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
In-Reply-To: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rob,

On Fri, Apr 29, 2016 at 10:56 AM, Rob Landley <rob@landley.net> wrote:
> On 04/29/2016 01:58 AM, Geert Uytterhoeven wrote:
>> On Thu, Apr 7, 2016 at 5:01 PM, Rich Felker <dalias@libc.org> wrote:
>>> --- /dev/null
>>> +++ b/arch/sh/boot/dts/j2_mimas_v2.dts
>>> @@ -0,0 +1,98 @@
>>> +/dts-v1/;
>>> +
>>> +/ {
>>> +       compatible = "jcore,j2-soc";
>>> +       model = "J2 FPGA SoC on Mimas v2 board";
>>> +
>>> +       #address-cells = <1>;
>>> +       #size-cells = <1>;
>>> +
>>> +       interrupt-parent = <&aic>;
>>> +
>>> +       cpus {
>>> +               #address-cells = <1>;
>>> +               #size-cells = <0>;
>>> +
>>> +               cpu@0 {
>>> +                       device_type = "cpu";
>>> +                       compatible = "jcore,j2";
>>
>> This brings an interesting question: how do you plan to do IP core versioning?
>> I.e. which version of the HDL code does "jcore,j2" correspond to?
>
> J2 has a stable instruction set based on sh2 plus 2 backported sh3
> barrel shift instructions and one added cmpxchg instruction. Other than
> the cmpxchg (which was added last year when we started adding SMP
> support) it's been stable for a couple years now. We're pondering a run
> of ASICs, which sets it in stone, and don't expect any instruction set
> changes between now and then. (That'll probably be our next kickstarter
> after the turtle boards.)

OK. So that's your answer for the CPU core.

What about the other IP cores, e.g. jcore,emac and jcore,spi2?
The latter already has a "2" suffix?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
