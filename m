From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 18 Sep 2014 16:54:59 +0000
Subject: Re: [PATCH v3] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Message-Id: <541B0E63.9080605@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3179866.4yEKrAKQ30@wasted.cogentembedded.com> <CAPDyKFq2H0zQjJvHy+Ogz0MbVsY8HAHDvDvr3+CTPvf0bc7xog@mail.gmail.com>
In-Reply-To: <CAPDyKFq2H0zQjJvHy+Ogz0MbVsY8HAHDvDvr3+CTPvf0bc7xog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>, Linux-sh list <linux-sh@vger.kernel.org>

Hello.

On 9/18/2014 1:03 AM, Ulf Hansson wrote:

>> I spent a couple of days with the driver just hanging due to me forgetting to
>> specify the external crystal frequency,  so that clk_get_rate() returned 0 and
>> thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
>> acceptable behavior, so I suggest that the minimum frequency is checked for 0
>> in tmio_mmc_host_probe().

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Cc: stable@vger.kernel.org

>> ---
>> The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' branch.

> Hi Sergei,

> Could you please rebase it towards next instead?

    Ah, I've misinterpreted your mail, thought that I should either rebase to 
next /or/ CC: stable. Will do.

> Kind regards
> Uffe

WBR, Sergei

