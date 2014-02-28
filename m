From: Benoit Cousson <bcousson@baylibre.com>
Date: Fri, 28 Feb 2014 10:22:14 +0000
Subject: Re: [PATCH v3] clk: shmobile: rcar-gen2: Use kick bit to allow Z clock frequency change
Message-Id: <53106356.6060003@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393521820-21805-1-git-send-email-bcousson@baylibre.com>
In-Reply-To: <1393521820-21805-1-git-send-email-bcousson@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Sergei,

On 27/02/2014 20:55, Sergei Shtylyov wrote:
> Hello.
>
> On 02/27/2014 08:23 PM, Benoit Cousson wrote:
>
>> The Z clock frequency change is effective only after setting the kick
>> bit located in the FRQCRB register.
>> Without that, the CA15 CPUs clock rate will never change.
>
>> Fix that by checking if the kick bit is cleared and enable it to make
>> the clock rate change effective. The bit is cleared automatically upon
>> completion.
>
>> Signed-off-by: Benoit Cousson <bcousson+renesas@baylibre.com>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> [...]
>
>> diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c
>> b/drivers/clk/shmobile/clk-rcar-gen2.c
>> index a59ec21..cbf8c59 100644
>> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
>> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
> [...]
>> @@ -83,17 +86,45 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw,
>> unsigned long rate,
> [...]
>> +    /*
>> +     * Note: There is no HW information about the worst case latency.
>> +     *
>> +     * Using experimental measurements, it seems that no more than
>> +     * ~10 iterations are needed, independently of the CPU rate.
>> +     * Since this value might be dependant of external xtal rate, pll1
>> +     * rate or even the other emulation clocks rate, use 1000 as a
>> +     * "super" safe value.
>> +     */
>> +    for (i =3D 1000; i; i--) {
>> +        if (clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
>> +            cpu_relax();
>> +        else
>> +            return 0;
>
>      This can be coded shorter:

Shorter, not necesserally since I will add an extra blank line :-)

>          if (!(clk_readl(zclk->kick_reg) & CPG_FRQCRB_KICK))
>              return 0;
>          cpu_relax();

But maybe slighty more readable...

OK, I'll go for a next round and repost it.

Thanks,
Benoit


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
