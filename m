From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Fri, 29 Jan 2016 08:29:12 +0000
Subject: Re: [RFC] clk: shmobile: r8a7795: Add SD divider support
Message-Id: <56AB22D8.3020002@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 29.01.2016 09:14, Wolfram Sang wrote:
>> Having the clock patch applied on top of your renesas/v8-sdhi branch [1] I
>> get
>>
>> root@salvator-x:/sys/kernel/debug/clk# cat clk_summary
>>     clock             enable_cnt  prepare_cnt        rate
>> --------------------------------------------------------
>> ...
>>      .main                     1            1     8333333
>>      ...
>>         .pll1                  1            1  1599999936
>>            .pll1_div2          2            2   799999968
>>               hdmi             0            0    24999999
>>                  hdmi0         0            0    24999999
>>                  hdmi1         0            0    24999999
>>               cl               0            0    16666666
>>               sd3              0            0    99999996
>>                  sdif3         0            0    99999996
>>               sd2              0            0    99999996
>>                  sdif2         0            0    99999996
>>               sd1              0            0    49999998
>>                  sdif1         0            0    49999998
>>               sd0              0            0    49999998
>>                  sdif0         0            0    49999998
>
> This is what I get (with your cleanup patch also applied):
>
> ...
>      .main                                 1            1     8333333          0 0
>      ...
>         .pll1                              1            1  1599999936          0 0
>            .pll1_div2                      3            3   799999968          0 0
>               hdmi                         0            0    24999999          0 0
>                  hdmi0                     0            0    24999999          0 0
>                  hdmi1                     0            0    24999999          0 0
>               cl                           0            0    16666666          0 0
>               sd3                          1            1   199999992          0 0
>                  sdif3                     1            2   199999992          0 0
>               sd2                          0            0    49999998          0 0
>                  sdif2                     0            0    49999998          0 0
>               sd1                          0            0    49999998          0 0
>                  sdif1                     0            0    49999998          0 0
>               sd0                          1            1    49999998          0 0
>                  sdif0                     1            2    49999998          0 0
>
> Could it be a firmware difference (i.e. bootloader trying to boot from eMMC and
> changing values)?


Yes, its U-Boot. I have U-Boot from rcar-3.0.3 BSP on the board and 
verified that it configures exactly the clock configuration I gave above.

Best regards

Dirk

Bes
