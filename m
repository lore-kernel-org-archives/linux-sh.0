From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 10 Feb 2016 18:43:06 +0000
Subject: Re: [PATCH 9/9] mmc: sdhi: Add r8a7795 support
Message-Id: <CAPDyKFrzFA_3MnkOPGLD7Fy84XAyx7+=utERbNF1cX31KWxHMg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
	<1453749316-1848-10-git-send-email-wsa@the-dreams.de>
	<CAPDyKFo6oXEAy562p7MTxw0eKYZe_nnT2q+hbLKF4Lv2kMUvGg@mail.gmail.com>
	<20160210163623.GA15453@katana>
In-Reply-To: <20160210163623.GA15453@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

On 10 February 2016 at 17:36, Wolfram Sang <wsa@the-dreams.de> wrote:
> ^
>> I think you should try without MMC_CAP_WAIT_WHILE_BUSY, and then check
>> that a following CMD13 command always states that the card isn't busy.
>> I think the best path to try this is when sending a big write data
>> request, as in that case you can be quite certain that the card gets
>> busy between the requests.
>>
>> So somewhere in the mmc block layer add some debug prints, that should do it.
>
> I'd think the mmc_test driver already helped me with this. I ran tests
> like 31 (Consecutive write performance by transfer size) or 36 (Large
> sequential write from scattered pages) which both succeeded without any
> warnings printed. And the code explicitly sends a CMD13 after transfer,
> checks for busy and prints a warning when MMC_CAP_WAIT_WHILE_BUSY is
> set and a busy state is detected. Nice test thing this driver is :)

That should do it!

>
> So, it looks to me that patch 9 is fine to go in?
>

Not yet. :-)

I suspect you are using a delayed work in this driver to deal with
request timeouts.

The value for the delay that is used, needs to be informed towards the
mmc core via the "->max_busy_timeout".

One more thing, as the documentation of your host controllers lacks
some information about the busy mode, perhaps it's worth to add some
comments about this in the code and as well in the change-log!?

Kind regards
Uffe
