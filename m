From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 08 Jul 2014 08:43:08 +0000
Subject: Re: [PATCH] sh-pfc: r8a7791: add CAN pin groups
Message-Id: <CACRpkdYpsSEjuaDiEHjjmtEaJRhj9MiJ218SGf2c3jEJoqAXJA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407010211.23665.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407010211.23665.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 1, 2014 at 9:11 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

>> +static const char * const can0_groups[] = {
>> +     "can0_data_a",
>> +     "can0_data_b",
>> +     "can0_data_c",
>> +     "can0_data_d",
>> +     "can0_data_e",
>> +     "can0_data_f",
>> +     "can_clk_a",
>> +     "can_clk_b",
>> +     "can_clk_c",
>> +     "can_clk_d",
>> +};
>> +
>> +static const char * const can1_groups[] = {
>> +     "can1_data_a",
>> +     "can1_data_b",
>> +     "can1_data_c",
>> +     "can1_data_d",
>> +     "can_clk_a",
>> +     "can_clk_b",
>> +     "can_clk_c",
>> +     "can_clk_d",
>
> Linus, can a group be listed as part of two different functions ?

Yeah sure, it's just an indication that this group can be mapped
onto this function. If you try to use both at the same time at runtime,
the subsystem will complain (hopefully).

Yours,
Linus Walleij
