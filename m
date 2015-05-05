From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 05 May 2015 08:47:10 +0000
Subject: Re: [Linux-kernel] [RFC PATCH 5/7] mmc: sh_mobile_sdhi: Add UHS-I mode support
Message-Id: <CAPDyKFpv0BOX0mAvhZx9j5Gnayt__YTiUa8SxvcmsEcuazsg0w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	<1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
	<CAPDyKFodZscxZJmKgYyMV8m8mNWYc9GitkoKbixTKS5r7rv_fA@mail.gmail.com>
	<554880C9.8080201@codethink.co.uk>
In-Reply-To: <554880C9.8080201-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 5 May 2015 at 10:35, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 05/05/15 10:56, Ulf Hansson wrote:
>> On 30 April 2015 at 14:32, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
>>> Implement voltage switch, supporting modes up to SDR-50.
>>>
>>> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
>>>
>>> This uses two voltage regulators, one external and one on the pfc.
>>
>> Why two? If there is a parent child relation ship, that should be
>> handled through the regulator tree, right!? Please elaborate.
>
> The card main power is separate from the IO line voltages.
>
> To get to the high-speed, card power is left at 3.3V and the IO
> voltage is changed to 1.8V.
>
> In the systems we have the power gate is separate from the controls
> for the IO but not integrated into the MMC controller itself.

Okay, that's what I was expecting and hoping for :-)

Then you need to rework $subject patch according to below.

1) Use mmc_regulator_get_supply() to fetch both the I/O voltage
regulator (vqmmc) and the main power regulator (vmmc).Your "vqmmc_ref"
regulator should thus be renamed to "vmmc".
2) The vmmc regulator should not be handled from the
->start_signal_voltage_switch() callback, since it's only vqmmc
voltage levels that should be changed from there.
3) The voltage levels changes for vmmc shall be handled via the
->set_ios() callback.

I suggest you go and have a look in drivers/mmc/host/mmci.c, that
should provide you with a good inspiration.

Kind regards
Uffe
