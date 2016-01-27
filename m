From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Wed, 27 Jan 2016 13:14:01 +0000
Subject: Re: [RFC] clk: shmobile: r8a7795: Add SD divider support
Message-Id: <56A8C299.5060702@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 27.01.2016 08:14, Wolfram Sang wrote:
> On Fri, Jan 22, 2016 at 01:26:26PM +0100, Dirk Behme wrote:
>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>
> So, I tested this patch and it basically works. I say basically because
> the SDHI code currently does not change the clock rate, only
> en-/disables it. UHS support will need to change the clock later.
>
> One thing I noticed: SD0-2 are 50MHz like the docs say. SD3 is 200MHz
> and I couldn't find a reason for that when having a glimpse. Dirk, can
> you check?


Having the clock patch applied on top of your renesas/v8-sdhi branch [1] 
I get

root@salvator-x:/sys/kernel/debug/clk# cat clk_summary
    clock             enable_cnt  prepare_cnt        rate
--------------------------------------------------------
...
     .main                     1            1     8333333
     ...
        .pll1                  1            1  1599999936
           .pll1_div2          2            2   799999968
              hdmi             0            0    24999999
                 hdmi0         0            0    24999999
                 hdmi1         0            0    24999999
              cl               0            0    16666666
              sd3              0            0    99999996
                 sdif3         0            0    99999996
              sd2              0            0    99999996
                 sdif2         0            0    99999996
              sd1              0            0    49999998
                 sdif1         0            0    49999998
              sd0              0            0    49999998
                 sdif0         0            0    49999998


Best regards

Dirk

[1] 
https://github.com/dirkbehme/linux-renesas-rcar-gen3/commits/wsa-renesas/v8-sdhi
