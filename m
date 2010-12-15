From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Date: Wed, 15 Dec 2010 07:59:40 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add mmcif support
Message-Id: <4D08756C.7050902@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus-san

(2010/12/15 16:39), Magnus Damm wrote:
> Hi Goda-san,
> 
> On Wed, Dec 15, 2010 at 4:35 PM, Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:
>> (2010/12/15 15:43), Magnus Damm wrote:
>>> 2010/12/15 Yusuke Goda <yusuke.goda.sx@renesas.com>:
>>>> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
>>>> ---
>>>> +static struct sh_mmcif_plat_data sh_mmcif_plat = {
>>>> +       .sup_pclk       = 0,
>>>> +       .ocr            = MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
>>>> +       .caps           = MMC_CAP_4_BIT_DATA |
>>>> +                         MMC_CAP_8_BIT_DATA |
>>>> +                         MMC_CAP_NEEDS_POLL,
>>>> +       .get_cd         = slot_cn7_get_cd,
>>>> +};
>>>
>>> Can we select VDD voltage on this board? I thought it was fixed to
>>> 3.3V? Or perhaps I don't understand how the OCR field is supposed to
>>> work.
>> The mackerel(and ap4evb) can select 1.8v or 3.3v by J22.
>> This OCR field set to support either voltage for the card inserted.
>> User have to change J22 depends the card to be used.
> 
> Ok, I understand. If it is not documented in the board source code
> already, please send a patch to add comment about J22 and the OCR
> field.
OK!
I send v2 patch.

/Goda

