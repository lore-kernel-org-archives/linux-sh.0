From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 11 Jul 2013 16:56:57 +0000
Subject: Re: emev2: clock driver dt proposal
Message-Id: <51DEE3D9.4030209@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <51DC4737.8020803@codethink.co.uk>
In-Reply-To: <51DC4737.8020803@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/07/13 17:44, Magnus Damm wrote:
> Hi Ben,
>
> On Thu, Jul 11, 2013 at 1:07 AM, Ben Dooks<ben.dooks@codethink.co.uk>  wrote:
>> On 09/07/13 18:24, Ben Dooks wrote:
>>>
>>> To deal with peripheral clocks, I was working on the following idea
>>> for a clock binding to deal with the gclk and sclks to each peripheral.
>>>
>>> The parent control devices:
>>>
>>> sclk: clock-controller@e011600 {
>>> compatible = "renesas,em-sclk";
>>> reg =<0xe011600 0x100>;
>>>
>>>
>>> #clock-cells =<2>;
>>> };
>>>
>>> This registers a clock-divider for the clock and a clock-mux to control
>>> the
>>> divder's parents.
>>>
>>> gclk: clock-controller@e011400 {
>>> compatible = "renesas,em-gclk";
>>> reg =<0xe011400 0x200>;
>>> #clock-cells =<3>;
>>> }
>>>
>>> This driver provides the clock gates for both the bus clock and the sclk.
>>>
>>>
>>> For each peripheral:
>>>
>>> shdci0 {
>>> clocks =<&gclk 0xc8 0x5 0x2>,<&sclk 0x48&pll3&pll4&osc0&osc1>;
>>> clock-names = "bus", "sclk";
>>> }
>>>
>>> In this case, the gclk is in the form of:
>>>
>>> <  &gclk register-offset-from-base bus-control-bitmask
>>> sclk-control-bitmask>
>>>
>>> And the sclk is in the form of:
>>>
>>> <  &sclk register-offset-from-base
>>> parent-clock-0 parent-clock-1 parent-clock-2 parent-clock-3>
>>
>>
>> Is anyone else working on EMEV2 clock-dt conversion, or should I go
>> ahead and start?
>
> Thanks for your proposal. It looks quite nice I must say.
>
> Kuribayashi-san [CC:ed] is currently working on EMEV2 CCF, so I'm
> afraid we have a collision.
>
> We had a face-to-face meeting earlier today and I was told that his
> current implementation is sort of half-done, so he has started but
> needs more time before having something to share. I think we can
> expect some output in a couple of weeks. At that time, can you please
> help out reviewing his code?
>
> If you want to help out with some other EMEV2 related activity then
> may I propose PINCTRL? Laurent [CC:ed] knows a lot about
> drivers/pinctl/sh-pfc/ which I suspect is a good place to hook in some
> EMEV2-specific tables. The gpio-em.c driver also needs to coexist with
> the PFC somehow, you may want to see how gpio-rcar.c does it.

Ok, I was hoping for something faster than that. Hacking stuff in to
the current clock-emev2.c is causing collisions when adding drivers.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
