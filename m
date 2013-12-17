From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Dec 2013 22:29:48 +0000
Subject: Re: [PATCH 02/05 v2] pinctrl: sh-pfc: r7s72100 base support
Message-Id: <CANqRtoRn--Ze3ayoag71iYTKXEG1eNa8qyXEAJ7vCZhRo5yHPw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131217023745.24573.3660.sendpatchset@w520>
	<20131217023804.24573.82351.sendpatchset@w520>
	<20131217210403.GA1196@katana>
In-Reply-To: <20131217210403.GA1196@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Wolfram,

On Wed, Dec 18, 2013 at 6:04 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Hi,
>
>> +#define _P_DATA(bank, pin, name, sfx)                                        \
>> +     PINMUX_DATA(name##_DATA, name##_PMC_0, name##_PIPC_0,           \
>> +                 name##_PIBC_1, name##_PBDC_1)
>> +
>> +#define _P_FN(n, fn, pfcae, pfce, pfc)                                       \
>> +     PINMUX_DATA(n##_MARK_FN##fn, n##_PMC_1, n##_PIPC_1,             \
>> +                 n##_PFCAE_##pfcae, n##_PFCE_##pfce, n##_PFC_##pfc)
>
> I need to apply this patch, otherwise my i2c pinmuxing fails?

Thanks. It looks to me like the _P_FN() bits would be mainly needed.
Can you try to omit the _P_DATA() portion and check if it is still
behaving as expected?

Cheers,

/ magnus
