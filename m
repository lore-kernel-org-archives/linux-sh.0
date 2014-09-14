From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 14 Sep 2014 19:39:25 +0000
Subject: Re: [PATCH v2] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Message-Id: <5415EEED.3020204@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2535223.qa7H57Aml3@wasted.cogentembedded.com> <CAPDyKFr8voHFgn5_yNpvJT6L3Dj--kjq7dy8qrc-uUg_r7278g@mail.gmail.com>
In-Reply-To: <CAPDyKFr8voHFgn5_yNpvJT6L3Dj--kjq7dy8qrc-uUg_r7278g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>, Linux-sh list <linux-sh@vger.kernel.org>

Hello.

    Sorry for delay: I'm on vacations and WiFi didn't work well here...

On 09/08/2014 03:17 PM, Ulf Hansson wrote:

>> I spent a couple of days with the driver just hanging due to me forgetting to
>> specify the external crystal frequency,  so that clk_get_rate() returned 0 and
>> thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
>> acceptable behavior, so I suggest that the minimum frequency is checked for 0
>> in tmio_mmc_host_probe().

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' branch.

> Hi Sergei,

> Could you please base it towards "next" instead, it doesn't apply. If
> you think this is important to go stable, I suggest you to add a
> stable tag for it.

    It's a bit of a corner case, of course, but the consequences are just too 
disastrous: AFAIR, an ARM kernel just silently hangs on boot, with no hints of 
where. So I'm going to CC: -stable.

> Kind regards
> Uffe

WBR, Sergei

