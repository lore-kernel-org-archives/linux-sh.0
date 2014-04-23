From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2014 02:01:43 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <CANqRtoSb955dm77hD_UcFy6G1esJfe=iE_N9f+KbVp-AYDWWww@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Mon, Apr 21, 2014 at 5:56 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Mon, Apr 21, 2014 at 3:31 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> A simple serial port integration prototype that happens to
>> target Koelsch. Written to propose how to move one step closer
>> to integrate DT support for serial ports on mach-shmobile.
>
> [...]
>
>> 1) It enables serial ports in the board specific DTS
>>   -> Nothing special here, except perhaps the preserved device order
>
> Good, thanks!

Thanks! =)

>> 2) It extends the existing platform device registration code
>>   -> When the existing C board code calls to add serial platform devices
>>      then we check if DT platform devices exist in the DTB. If so then
>>      we disable the serial DT devices and stick with platform devices.
>
> Is there any specific reason why you chose this solution, over the alternative
> approach of not registering the platform devices if the corresponding serial
> devices are present in DT?

At first it seemed more logical to disable the platform devices when
serial DT devices existed, however after considering how the rest of
the C board code operates I came to think that it would be most sane
to keep the devices the same in case board code written in C while
still allowing the DT-only case to use serial DT as expected. This way
Legacy board code and DT reference board code written in C keep on
behaving the same. Basically we end up with two cases:

A) DT-only board support (Only sane way forward for upstream development)

-> These use serial ports described in DTB but allow easy use together
with same DTB as in B) by keeping the serial order as before. This is
where we develop and integrate upstream support. This is what we
should care about.

B) Board code written in C (Legacy + DT reference)

-> I propose that these will keep on using platform devices written in
C until we phase out the actual C board code. Changing this around
does not make any sense IMO (just migration pain, no real upside),
focus for upstream development should be put on A) to allow us
removing B) as soon as possible.

The real questions are IMO:

What needs to be done so we can phase out B)? Can we pour effort from
changing around B) into improving A)?

>> --- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
>> +++ work/arch/arm/mach-shmobile/setup-r8a7791.c 2014-04-17 16:32:32.000000000 +0900
>> @@ -94,7 +94,9 @@ static struct plat_sci_port scif##index#
>>  static struct resource scif##index##_resources[] = {                   \
>>         DEFINE_RES_MEM(baseaddr, 0x100),                                \
>>         DEFINE_RES_IRQ(irq),                                            \
>> -}
>> +};                                                                     \
>> +                                                                       \
>> +static struct property scif##index##_property
>
> This is static, as the property's lifecycle dictates it to stay alive...
>
>>  #define R8A7791_SCIF(index, baseaddr, irq)                             \
>>         __R8A7791_SCIF(PORT_SCIF, index, baseaddr, irq)
>> @@ -121,7 +123,30 @@ R8A7791_SCIFA(12, 0xe6c70000, gic_spi(29
>>  R8A7791_SCIFA(13, 0xe6c78000, gic_spi(30)); /* SCIFA4 */
>>  R8A7791_SCIFA(14, 0xe6c80000, gic_spi(31)); /* SCIFA5 */
>>
>> +static void serial_disable_dt(struct resource *res, struct property *prop)
>> +{
>> +       struct device_node *np;
>> +       char str[17];
>> +       char *disabled = "disabled";
>
> ... while this is a local variable on the stack, with limited lifetime.
> So that should be:
>
>         static char disabled[] = "disabled";
>
>> +       snprintf(str, ARRAY_SIZE(str), "/serial@%08x",
>> +                (unsigned int)res->start);
>> +
>> +       np = of_find_node_by_path(str);
>> +       if (np) {
>> +               if (of_device_is_available(np)) {
>> +                       prop->name = "status";
>> +                       prop->length = strlen(disabled) + 1;
>
> Or "sizeof(disabled)", after changing to a static array.
>
>> +                       prop->value = disabled;
>> +                       of_update_property(np, prop);
>> +                       printk("xxx disabled %s\n", str);
>
> pr_info(), drop the "xxx ", capitalize "Disabled".
>
>> +               }
>> +               of_node_put(np);
>> +       }
>> +}
>> +
>>  #define r8a7791_register_scif(index)                                          \
>> +       serial_disable_dt(scif##index##_resources, &scif##index##_property);   \
>>         platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
>>                                           scif##index##_resources,             \
>>                                           ARRAY_SIZE(scif##index##_resources), \

Thanks for the feedback. As you probably can tell, this ended up as a
pretty quick unpolished hack! =)

I don't intend to update this prototype. After discussion and
agreement about how to integrate the DT serial devices I think Simon
should continue the actual integration - perhaps using code from here
if that's what we agree on.

Cheers,

/ magnus
